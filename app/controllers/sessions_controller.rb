class SessionsController < ApplicationController
  post "/sessions" do
    user = User.find_by(username: json_request_body[:username])

    if user && user.authenticate(json_request_body[:password])
      session[:user_id] = user.id

      json(user.as_json)
    else
      status(401)
      json({})
    end
  end

  delete "/sessions" do
    session.clear
    json({})
  end
end
