# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.3'

gem 'cssbundling-rails'
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'tzinfo-data', platforms: %i[windows jruby]

# Assets
gem 'font-awesome-rails'
gem 'jsbundling-rails'
gem 'mini_racer'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'uglifier'

# UI/UX
gem 'bootsnap', require: false
gem 'jbuilder'
gem 'meta-tags'
gem 'rails-i18n'

# device
gem 'devise'
gem 'devise-i18n'

# omniauth
gem 'omniauth'
gem 'omniauth-line'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-google-oauth2'
# line-bot
gem 'line-bot-api'

gem 'rakuten_web_service'

gem 'ransack'

gem 'kaminari'

gem 'active_hash'

gem "chartkick"

# image_uploader
gem 'carrierwave'
gem 'mini_magick'

gem 'aws-sdk-s3', require: false
gem 'fog-aws'

gem 'faker'
gem 'seed-fu'

group :development, :test do
  # Debugging tools
  gem 'debug', platforms: %i[mri windows]
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'

  # RSpec
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  # rspec高速化
  gem 'spring-commands-rspec'

  # Code Analysis
  gem 'bullet'
  # RuboCop
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'

  # env
  gem 'dotenv-rails'
  # cron
  gem 'whenever', require: false
end

group :development do
  gem 'annotate'
  gem 'letter_opener_web'
  gem 'rails-erd'
  gem 'spring'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'fuubar'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'timecop'
  gem 'database_cleaner'
end
