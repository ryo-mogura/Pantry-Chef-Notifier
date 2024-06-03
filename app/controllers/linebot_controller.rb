class LinebotController < ApplicationController
  require 'line/bot'

  def callback
    # リクエストのbody（StringIOクラス）を文字列（Stringクラス）に変更
    body = request.body.read
    # parse_events_fromはline-bot-apiのオリジナルメソッド
    # clientは以下で定義したプライベートアクション（が返したインスタンス）
    events = client.parse_events_from(body)

    # eventsは配列に入っているので、eachでアクセス。events[0]でもだいたい同じ。
    events.each do |event|
      case event
      when Line::Bot::Event::Message # eventが「Message」のとき
        case event.type
        when Line::Bot::Event::MessageType::Text # さらに、送られてきたのがテキストだったとき
          # 送り返すメッセージを作成
          message = {
            type: 'text',
            text: event.message['text']
          }

          # メッセージを送り返す
          client.reply_message(event['replyToken'], message)
        end
      end
    end
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }
  end

end
