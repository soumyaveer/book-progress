ENV["RACK_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError
end

desc "open pry"
task :console do
  Pry.start
end
