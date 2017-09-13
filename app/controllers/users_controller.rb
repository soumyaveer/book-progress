require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/users' do
    @users = User.all
    erb :'/users/index'
  end

  get '/users/homepage' do
    erb :'/users/homepage'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if logged_in?
      redirect '/users/homepage'
    else
      erb :'/users/signup'
    end
  end

  post '/signup' do
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if user.save
      session[:user_id] = user.id
      redirect '/users/homepage'
    else
      flash[:message] = "Signup Failed! Please try again."
      redirect '/signup'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/users/homepage'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/users/homepage'
    else
      flash[:message] = "Mismatched Username or Password!!"
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
end
