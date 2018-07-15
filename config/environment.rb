ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

require_relative "database_config"
require_all 'app'
require 'pry'
require 'rack-flash'
