source 'http://rubygems.org'
ruby '2.5.1'

gem 'sinatra'
gem 'activerecord', :require => 'active_record'
gem 'sinatra-activerecord', :require => 'sinatra/activerecord'
gem "sinatra-contrib", require: false
gem 'rack-flash3'
gem 'rake'
gem 'require_all'
gem 'bcrypt'
gem 'rest-client'

# Servers
gem 'puma'
gem 'pg', '~> 0.18'

group :development, :test do
  gem 'database_cleaner', git: 'https://github.com/bmabey/database_cleaner.git'
  gem "faker"
end

group :development do
  gem 'foreman'
  gem 'pry'
  gem 'tux'
end

group :test do
  gem 'rspec'
  gem 'capybara'
  gem 'rack-test'
end