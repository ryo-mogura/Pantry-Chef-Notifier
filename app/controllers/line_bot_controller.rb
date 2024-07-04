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
    line_id = event['source']['userId']  # eventはメソッドのスコープ外で定義されていると仮定する
    user = User.find_by(uid: line_id)
    return user  # ユーザーが見つかった場合にそのユーザーを返す
  end
  # メッセージ処理
  def main_event(event, user)
    case event
    when Line::Bot::Event::Message
      case event.type
      when Line::Bot::Event::MessageType::Text
        message = create_message(event.message['text'], user)
        client.reply_message(event['replyToken'], message)
      end
    end
  end
  # LineBotからユーザーへのメッセージ生成
  def create_message(text, user)
    # user.update(status: 'idle')
    case text
    when '食材リスト'
      food_list(send_foods_item(user), text)
    when '消費期限'
      food_list(send_food_limits(user), text)
    when 'レシピ検索'
      recipe_branch(user)
    when '食材登録'
      case user.status
      when 'idle'
        user.update(status: 'waiting_add_food_name')
        { type: 'text', text: '登録する食材名を入力してください' }
      end
    else
      if user.status == 'waiting_for_recipe'
        recipe_branch(user, text)
      elsif  user.status == 'waiting_add_food_name'
        temp_food = user.line_messages.create(temp_name: text)
        user.update(status: 'waiting_add_food_quantity')
        { type: 'text', text: '在庫数を数字で入力してください。' }
      elsif user.status == 'waiting_add_food_quantity'

        temp_food = user.line_messages.last
        temp_food.update(temp_quantity: text)
        user.update(status: 'waiting_add_food_expiration')
        { type: 'text', text: '消費期限を入力してください。例）2024-07-25' }

      elsif user.status == 'waiting_add_food_expiration'

        user.update(status: 'waiting_add_food_storage')
        temp_food = user.line_messages.last
        temp_food.update(temp_expiration_date: text)
        { type: 'text', text: '保存場所を数字で入力してください。0: 冷蔵庫 1: 冷凍庫 2: その他' }

      elsif user.status == 'waiting_add_food_storage'

        user.update(status: 'waiting_add_food_image')
        temp_food = user.line_messages.last
        temp_food.update(temp_storage: text)
        { type: 'text', text: '画像を送信してください' }

      elsif user.status == 'waiting_add_food_image'
        temp_food = user.line_messages.last
        user.update(status: 'idle')
        food = Food.new(
                name: temp_food.temp_name,
                quantity: temp_food.temp_quantity,
                expiration_date: temp_food.temp_expiration_date,
                storage: temp_food.temp_storage.to_i,
                user_id: user.id
              )
        if food.save
          saved_food = Food.find_by(name: temp_food.temp_name, user_id: user.id)
          response = "以下の食材が保存されました。\n\n食材名: #{saved_food.name}\n在庫数: #{saved_food.quantity}\n消費期限: #{saved_food.expiration_date}\n保存場所: #{saved_food.storage}"
        else
          response = 'エラーが発生しました。正しく入力してください。'
        end
        { type: 'text', text: response }
      else
        user.update(status: 'idle')
        { type: 'text', text: 'エラーが発生しました。正しく入力してください。' }
      end
    end
  end
  # 食材リストの取得とメッセージ生成
  def send_foods_item(user)
    food_items =  Food.where(user_id: user.id)
    if food_items != []
      names = food_items.map(&:name)
      quantity = food_items.map(&:quantity)
      result = names.zip(quantity).map { |name, qty| "#{name} : 在庫数#{qty}" }.join("\n")
      response = "以下の食材があります。\n\n#{result}"
    else
      response = '食材が登録されていません。'
    end
  end
  # 期限が近づいている食材の取得とメッセージの生成
  def send_food_limits(user)
    limit_second_days = Date.today..Time.now.end_of_day + 2.days
    limit_foods =  Food.where(user_id: user.id).where(expiration_date: limit_second_days)
    if limit_foods != []
      names = limit_foods.map(&:name)
      expiration_dates = limit_foods.map(&:expiration_date)
      result = names.zip(expiration_dates).map { |name, expiration_date| "#{name} : 消費期限#{expiration_date}" }.join("\n")
      response = "以下の食材の消費期限が近づいています（二日以内）。\n早めに消費することをオススメします。\n\n#{result}"
    else
      response = '二日以内が期限の食材はありません。'
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

  # 食材の画登録処理
  # def

  # end
end
