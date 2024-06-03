
namespace :line_notification do
  desc "LINEBOT : 食材の消費期限の通知"
  task :push_line_message_expiration_date => :environment do
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }


    User.find_each do|user|
        limit_expiration = user.foods.where(expiration_date: Date.today)
        limit_expiration.each do |f|
            message = {
                type: 'text',
                text: "「#{f.name}」の設定した期限は今日です!!"
            }
            response = client.push_message(user.uid, message)
            p response
        end
    end
  end
end
# docker compose exec web bash後
# rails line_notification:push_line_message_expiration_date
