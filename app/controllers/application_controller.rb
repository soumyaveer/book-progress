require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  configure :development do
    register Sinatra::Reloader
  end

  def authenticate
    redirect '/login' unless logged_in?
  end

  get '/' do
    if logged_in?
      redirect '/users/homepage'
    else
      erb :'/index'
    end
  end

  get '/sample' do
    erb :sample
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
