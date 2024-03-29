source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 5.3.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Use FlopiClockjs to create any type of clock or counter.
gem 'flipclockjs-rails', '~> 0.7.7'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

gem 'droplet_kit'
gem 'exception_notification'
gem 'jwt'
gem 'meta-tags'
gem 'paperclip', '~> 6.0.0'
gem 'slack-notifier'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Processamento de imagens
gem 'image_processing', '~> 1.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# gems para layout
gem 'jquery-fileupload-rails'
gem 'jquery-rails'
gem 'jquery-turbolinks'

# gem 'materialize-sass', '~> 0.100.2'
gem 'will_paginate'
# gem 'will_paginate-materialize'
gem 'will_paginate-bootstrap4'

# gems para utilidades
gem 'correios-cep'
gem 'nested_form_fields'

# gem para jobs programados
gem 'crono'
gem 'daemons'
gem 'haml'
gem 'sinatra', require: nil

# GEM PARA TRABALHAR COM DINHEIRO
gem 'money-rails'

# Rack Middleware for handling Cross-Origin Resource Sharing (CORS), which makes cross-origin AJAX possible.
gem 'rack-cors'
# Devise is a flexible authentication solution for Rails based on Warden
gem 'devise'
# Minimal authorization through OO design and pure Ruby classes
gem 'pundit'
# Fast, Nimble PDF Writer for Ruby http://prawnpdf.org
gem 'prawn'
# Object-based searching. http://ransack-demo.herokuapp.com
gem 'ransack'
# Provides support for tables in Prawn
gem 'prawn-table'
# ActiveModel::Serializer implementation and Rails hooks
gem 'active_model_serializers', '~> 0.10.7'
# Audited (formerly acts_as_audited) is an ORM extension that logs all changes to your Rails models.
gem 'audited', '~> 4.6'
# Dynamic nested forms using jQuery made easy; works with formtastic, simple_form or default forms http://github.com/nathanvda/cocoon
gem 'cocoon'
# A library for generating fake data such as names, addresses, and phone numbers.
# gem 'faker'
# Generates Brazilian CPF numbers for use in testing.
# gem 'cpf_faker'
# Builder provides a number of builder objects that make creating structured data simple to do.
gem 'builder', '~> 3.2', '>= 3.2.2'
# Implementation of SFTP connection to send or receive files
gem 'fun_sftp'

gem 'cpf_cnpj'
gem 'validators'
# gem "chartkick"

gem 'rest-client'

gem 'delocalize'

gem 'exception_logger', github: 'ryancheung/exception_logger'

gem 'simple_token_authentication', '~> 1.0'

gem 'wdm', '>= 0.1.0' if Gem.win_platform?

# toastr
gem 'toastr-rails'

# Makes http fun! Also, makes consuming restful web services dead easy.
gem 'faraday'
gem 'httparty', '>= 0.13.7'

group :development, :test, :homologation do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'pry-byebug'
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'cpf_faker'
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'rspec-rails', '~> 3.6'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'rails-controller-testing'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'vcr'
  gem 'webmock'
end

group :development, :homologation do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
  gem 'webdrivers', '~> 4.0', require: false
end
