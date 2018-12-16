source "http://rubygems.org"
ruby "2.5.3"

gem "activerecord", require: "active_record"
gem "bcrypt"
gem "rack-flash3"
gem "rake"
gem "require_all"
gem "rest-client"
gem "sinatra"
gem "sinatra-activerecord", require: "sinatra/activerecord"
gem "sinatra-contrib", require: false

# Servers
gem "pg", "~> 0.18"
gem "puma"

group :development, :test do
  gem "database_cleaner", git: "https://github.com/bmabey/database_cleaner.git"
  gem "faker"
end

group :development do
  gem "foreman"
  gem "pry"
  gem "rubocop", "0.59.2"
  gem "scss_lint"
  gem "tux"
end

group :test do
  gem "capybara"
  gem "simplecov"
  gem "simplecov-cobertura"
  gem "rack-test"
  gem "rspec_junit_formatter"
  gem "rspec"
end
