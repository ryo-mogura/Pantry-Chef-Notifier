# frozen_string_literal: true

require File.expand_path("#{File.dirname(__FILE__)}/environment")

# cronを実行する環境変数
rails_env = ENV['RAILS_ENV'] || :development

# cronを実行する環境変数をセット
set :environment, rails_env

# cronのログの吐き出し場所
set :output, "#{Rails.root}/log/cron.log"

every 1.day, at: '4:58 pm' do
  rake 'line_notification:push_line_message_expiration_date'
end
