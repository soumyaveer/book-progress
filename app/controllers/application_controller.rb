require "./config/environment"

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, "public"
    set :views, "app/views"
    enable :sessions
    set :session_secret, "secret"
    use Rack::CommonLogger, STDOUT
  end

  configure :development do
    require "sinatra/reloader"
    register Sinatra::Reloader
  end

  def authenticate
    redirect "/login" unless logged_in?
  end

  get "/" do
    erb :'/index'
  end

  helpers do
    def current_user
      User.find(session[:user_id])
    end

    def logged_in?
      !!session[:user_id]
    end
  end
end
