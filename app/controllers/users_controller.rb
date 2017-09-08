class UsersController < ApplicationController

  get '/homepage' do
    erb :'/users/homepage'
  end

  get '/signup' do
    if logged_in?
      redirect '/homepage'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/homepage'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/homepage'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/homepage'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect '/'
    end
  end

  get '/index' do
    @users = User.all
    erb :'/users/index'
  end
end
