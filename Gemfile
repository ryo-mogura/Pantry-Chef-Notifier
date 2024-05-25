# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.3'

gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.2'
gem 'cssbundling-rails'
gem 'tzinfo-data', platforms: %i[windows jruby]

# Assets
gem 'font-awesome-rails'
gem 'jsbundling-rails'
gem 'sprockets-rails'
gem 'uglifier'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'mini_racer'

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


group :development, :test do
  # Debugging tools
  gem 'debug', platforms: %i[mri windows]
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'

  # RSpec
  gem 'factory_bot_rails'
  gem 'rspec-rails'

  # Code Analysis
  gem 'bullet'
  # RuboCop
  gem 'rubocop', require: false
  gem 'rubocop-checkstyle_formatter'
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'

  # Seed Data
  gem 'seed-fu'
  
  # env
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console'
  gem 'rails-erd'
  gem 'annotate'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'faker'
  gem 'fuubar'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'timecop'
end
