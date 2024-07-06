# frozen_string_literal: true

class LineBotController < ApplicationController
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery except: [:callback]
  include FoodHelper

  def callback
    body = request.body.read
    events = client.parse_events_from(body)
    #  Lineからのリクエストであることを確認するために、リクエストの署名を検証
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      render plain: 'Bad Request', status: 400
      return
    end
    # LineBotの処理
    events.each do |event|
      user = find_user(event)
      main_event(event, user)
    end
    head :ok
  end

  private

  # LINE Messaging API SDKのLine::Bot::Clientクラスをインスタンス化
  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end
  # ユーザー検索
  def find_user(event)
    line_id = event['source']['userId']
    user = User.find_by(uid: line_id)
    return user
  end
  # メッセージ処理
  def main_event(event, user)
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = create_message(event.message['text'], user, event)
        client.reply_message(event['replyToken'], message)
      when Line::Bot::Event::MessageType::Image
        handle_image_message(event, user)
      end
    end
  end
  # LineBotからユーザーへのメッセージ生成
  def create_message(text, user, event)
    case text
    when '食材リスト'
      { type: 'text', text: send_foods_item(user) }
    when '消費期限'
      { type: 'text', text: send_food_limits(user) }
    when 'レシピ検索'
      recipe_branch(user)
    when '食材の登録'
      if user.status == 'idle'
        user.update(status: 'waiting_add_food_name')
        { type: 'text', text: '登録する食材名を入力してください' }
      end
    when 'スキップ'
      if user.status == 'waiting_add_food_image'
        user.update(status: 'idle')
        save_food_without_image(user, event)
      end
    else
      handle_text_message(text, user)
    end
  end
# 画像メッセージの処理
  def handle_image_message(event, user)
    if user.status == 'waiting_add_food_image'
      file = fetch_image_file(event.message['id'])
      if file
        save_food_with_image(file, user, event)
      else
        respond_with_error(event)
      end
    else
      respond_with_error(event)
    end
  end

# 食材登録の対話機能の条件分岐（食材名、在庫数、消費期限、保存場所）
  def handle_text_message(text, user)
    case user.status
    when 'waiting_for_recipe'
      recipe_branch(user, text)
    when 'waiting_add_food_name'
      temp_food = user.line_messages.create(temp_name: text)
      user.update(status: 'waiting_add_food_quantity')
      { type: 'text', text: '在庫数を数字で入力してください。' }
    when 'waiting_add_food_quantity'
      temp_food = user.line_messages.last
      temp_food.update(temp_quantity: text)
      user.update(status: 'waiting_add_food_expiration')
      { type: 'text', text: '消費期限を入力してください。例）2024-07-25' }
    when 'waiting_add_food_expiration'
      temp_food = user.line_messages.last
      temp_food.update(temp_expiration_date: text)
      user.update(status: 'waiting_add_food_storage')
      { type: 'text', text: '保存場所を数字で入力してください。0: 冷蔵庫 1: 冷凍庫 2: その他' }
    when 'waiting_add_food_storage'
      temp_food = user.line_messages.last
      temp_food.update(temp_storage: text)
      user.update(status: 'waiting_add_food_image')
      { type: 'text', text: '画像を送信してください。画像を保存しない場合は「スキップ」と入力してください。' }
    else
      user.update(status: 'idle')
      { type: 'text', text: 'エラーが発生しました。正しく入力してください。' }
    end
  end

  # messageIDから画像ファイルを一時保存
  def fetch_image_file(message_id)
    response = client.get_message_content(message_id)
    file = Tempfile.new(['line_image', '.jpg'])
    file.binmode
    file.write(response.body)
    file.rewind
    file
  end

  # Foodオブジェクトの作成(画像あり)
  def save_food_with_image(file, user, event)
    temp_food = user.line_messages.last
    food = Food.new(
      name: temp_food.temp_name,
      quantity: temp_food.temp_quantity,
      expiration_date: temp_food.temp_expiration_date,
      storage: temp_food.temp_storage.to_i,
      user_id: user.id,
      food_image: file
    )

    file.close
    file.unlink

    if food.save
      response_text = "以下の食材が保存されました。\n\n食材名: #{food.name}\n在庫数: #{food.quantity}\n消費期限: #{food.expiration_date}\n保存場所: #{food.storage}"
    else
      response_text = 'エラーが発生しました。正しく入力してください。'
    end
    user.update(status: 'idle')
    client.reply_message(event['replyToken'], { type: 'text', text: response_text })
  end

  # Foodオブジェクトの作成(画像なし)
  def save_food_without_image(user, event)
    temp_food = user.line_messages.last
    food = Food.new(
      name: temp_food.temp_name,
      quantity: temp_food.temp_quantity,
      expiration_date: temp_food.temp_expiration_date,
      storage: temp_food.temp_storage.to_i,
      user_id: user.id,
    )

    if food.save
      response_text = "以下の食材が保存されました。\n\n食材名: #{food.name}\n在庫数: #{food.quantity}\n消費期限: #{food.expiration_date}\n保存場所: #{food.storage}"
    else
      response_text = 'エラーが発生しました。正しく入力してください。'
    end
    user.update(status: 'idle')
    client.reply_message(event['replyToken'], { type: 'text', text: response_text })
  end

  # エラーの場合の処理
  def respond_with_error(event)
    client.reply_message(event['replyToken'], { type: 'text', text: 'エラーが発生しました。正しく入力してください。' })
    user.update(status: 'idle')
  end

  # 食材リストの取得とメッセージ生成
  def send_foods_item(user)
    food_items = Food.where(user_id: user.id)
    if food_items.any?
      names = food_items.map(&:name)
      quantity = food_items.map(&:quantity)
      result = names.zip(quantity).map { |name, qty| "#{name} : 在庫数#{qty}" }.join("\n")
      "以下の食材があります。\n\n#{result}"
    else
      '食材が登録されていません。'
    end
  end

  # 期限が近づいている食材の取得とメッセージの生成
  def send_food_limits(user)
    limit_second_days = Date.today..Time.now.end_of_day + 2.days
    limit_foods = Food.where(user_id: user.id, expiration_date: limit_second_days)
    if limit_foods.any?
      names = limit_foods.map(&:name)
      expiration_dates = limit_foods.map(&:expiration_date)
      result = names.zip(expiration_dates).map { |name, expiration_date| "#{name} : 消費期限#{expiration_date}" }.join("\n")
      "以下の食材の消費期限が近づいています（二日以内）。\n早めに消費することをオススメします。\n\n#{result}"
    else
      '二日以内が期限の食材はありません。'
    end
  end
  # レシピ検索の対話機能の条件分離
  def recipe_branch(user, food_name = nil)
    case user.status
    when 'idle'
      user.update(status: 'waiting_for_recipe')
      { type: 'text', text: '食材名を入力してください' }
    when 'waiting_for_recipe'
      if food_name
        category = RakutenWebService::Recipe.small_categories.find { |c| c.name.match(food_name) }
        if category.nil?
          { type: 'text', text: '検索結果はありません' }
        else
          recipes = category.ranking
          message = FoodHelper.recipes_list(recipes, 'レシピ一覧')
          user.update(status: 'idle')
          message
        end
      else
        { type: 'text', text: '食材名を入力してください' }
      end
    end
  end
end
