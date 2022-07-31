# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'activestorage-cloudinary-service'
gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.1.3'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.6'
gem 'carrierwave'
gem 'client_side_validations'
gem 'cloudinary'
gem 'devise'
gem 'devise-bootstrap-views'
gem 'devise_invitable', '~> 2.0', '>= 2.0.6'
gem 'erb-formatter', '~> 0.3.0'
gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
gem 'importmap-rails'
gem 'jbuilder'
gem 'jquery-rails'
gem 'kaminari'
gem 'loading_screen', '~> 0.2.3'
gem 'mimemagic'
gem 'pay', '~> 3.0', '>= 3.0.24'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'pundit'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'redis', '~> 4.0'
gem 'sidekiq'
gem 'sidekiq-cron'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'stripe', '~> 5.53'
gem 'turbo-rails'
gem 'twitter-bootstrap-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'capybara'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'guard-rspec'
  gem 'pry-byebug', '~> 3.9'
  gem 'rails-controller-testing'
  gem 'rspec-rails'
  gem 'spring-commands-rspec'
  gem 'vcr'
end

group :development do
  gem 'web-console'
end

group :production do
  gem 'heroku-deflater'
end

group :test do
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'stripe-ruby-mock', '~> 2.2', '>= 2.2.1'
  gem 'webdrivers'
end

gem 'simplecov', require: false, group: :test
