class LineBotController < ApplicationController
  # callbackアクションのCSRFトークン認証を無効
  protect_from_forgery :except => [:callback]

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
      user_id = event['source']['userId']
      user = User.where(uid: user_id)[0]

      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          if event.message["text"] == "食材リスト"
            message = food_list(send_foods_item(user), event.message["text"])
          elsif event.message["text"].include?("消費期限")
            message = food_list(send_food_limits(user), event.message["text"])
          else
            message = {
              type: "text",
              text: event.message["text"]
            }
          end
          # message = [{type: "text", text: "メッセージ1"}, {type: "text", text: 'メッセージ2'}] #複数の返答の場合
          client.reply_message(event['replyToken'], message)
        end
      end
    end
    head :ok
  end

  private
  # LINE Messaging API SDKのLine::Bot::Clientクラスをインスタンス化
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def send_foods_item(user)
    food_items =  Food.where(user_id: user.id)
    if food_items != []
      names = food_items.map {|item| item.name }
      quantity = food_items.map {|item| item.quantity }
      result = names.zip(quantity).map { |name, qty| "#{name} : 在庫数#{qty}" }.join("\n")
      response = "以下の食材があります。\n\n#{result}"
    else
      response = "食材が登録されていません。"
    end
  end
  def send_food_limits(user)
    limit_second_days = Date.today..Time.now.end_of_day + (2.days)
    limit_foods =  Food.where(user_id: user.id).where(expiration_date: limit_second_days)
    if limit_foods != []
      names = limit_foods.map {|item| item.name }
      expiration_dates = limit_foods.map {|item| item.expiration_date }
      result = names.zip(expiration_dates).map { |name, expiration_date | "#{name} : 消費期限#{expiration_date}" }.join("\n")
      response = "以下の食材の消費期限が近づいています（二日以内）。\n早めに消費することをオススメします。\n\n#{result}"
    else
      response = "二日以内が期限の食材はありません。"
    end
  end
end
