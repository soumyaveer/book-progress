class SessionsController < ApplicationController
  post "/sessions" do
    request_body = JSON.parse(request.body.read).with_indifferent_access
    user = User.find_by(username: request_body[:username])

    if user && user.authenticate(request_body[:password])
      session[:user_id] = user.id

      json(user.as_json)
    else
      status 401
      json({})
    end
  end

  delete "/sessions" do
    session.clear
    json({})
  end
end
