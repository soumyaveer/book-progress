describe SessionsController do
  before do
    @user = create_user
  end

  describe "POST /sessions, format JSON" do
    context "when a user for the specified email is found and the password matches" do
      it "records the user id found in session and responds with a 200 response code" do
        post "/sessions", {
          username: @user.username,
          password: @user.password
        }.to_json

        expect(last_response.status).to eql(200)
        expect(last_request.env.fetch("rack.session").fetch("user_id")).to eql(@user.id)
        expect(last_response.body).to eql(@user.as_json.to_json)
      end
    end

    context "when a user for the specified email is found but the password does not match" do
      it "responds with errors with a 401 response code" do
        post "/sessions", {
          username: @user.username,
          password: "bad password"
        }.to_json

        expect(last_response.status).to eql(401)
        expect(last_request.env.fetch("rack.session").key?("user_id")).to eql(false)
        expect(last_response.body).to eql({}.to_json)
      end
    end

    context "when a user for the specified email is not found" do
      it "responds with errors with a 401 response code" do
        post "/sessions", {
          username: "bad username",
          password: @user.password
        }.to_json

        expect(last_response.status).to eql(401)
        expect(last_request.env.fetch("rack.session").key?("user_id")).to eql(false)
        expect(last_response.body).to eql({}.to_json)
      end
    end
  end

  describe "DELETE /sessions" do
    it "clears the 'user_id' key from the session" do
      delete "/sessions", {}, "rack.session" => { user_id: @user.id }

      expect(last_response.status).to eql(200)
      expect(last_request.env.fetch("rack.session").key?("user_id")).to eql(false)
      expect(last_response.body).to eql({}.to_json)
    end
  end
end
