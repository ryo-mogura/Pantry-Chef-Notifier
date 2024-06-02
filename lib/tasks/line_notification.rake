
namespace :line_notification do
  desc "LINEBOT : 食材の消費期限の通知"
  task :push_line_message_expiration_date => :environment do
      client = Line::Bot::Client.new { |config|
          config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
          config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }

      limit_expiration = Food.where(expiration_date: Date.today)
      limit_expiration.each do |t|
          message = {
              type: 'text',
              text: "「#{t.name}」の設定した期限は今日です!!"
          }
          response = client.push_message(t.uid, message)
          p response
      end
  end
end
