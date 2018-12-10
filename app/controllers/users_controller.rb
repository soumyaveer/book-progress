class UsersController < ApplicationController
  get "/api/users" do
    users = User.all
    json users: users.as_json
  end

  post "/users" do
    request_body = JSON.parse(request.body.read).with_indifferent_access
    user = User.new(username: request_body[:username], email: request_body[:email], password: request_body[:password])

    if user.save
      session[:user_id] = user.id
      json(user.as_json)
    else
      status 422
      user_json = user.as_json
      user_json[:errors] = user.errors.full_messages

      json(user_json)
    end
  end
end
