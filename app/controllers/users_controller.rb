class UsersController < ApplicationController
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
end
