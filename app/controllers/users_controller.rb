require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/api/users' do
    users = User.all
    json users: users.as_json
  end

  get '/users/homepage' do
    authenticate
    erb :'/users/homepage'
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
      flash[:message] = user.errors.full_messages.join(', ')
      redirect '/signup'
    end
  end
end
