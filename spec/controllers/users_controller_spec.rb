describe UsersController do
  describe "Signup" do
    it 'returns 200 status code when page is successfully loaded' do
      get '/signup'
      expect(last_response.status).to eql(200)
    end

    it 'loads the signup page' do
      get '/signup'
      expect(last_response.body).to include("Create A New Account")
    end

    it 'redirects user to users homepage when signup in successful' do
      params = {
        username: "test-name",
        email: "email@test.com",
        password: "test1"
      }

      post '/signup', params
      expect(last_response.location).to include("/homepage")
    end

    it 'redirects user to signup page if username is not present' do
      params = {
        username: "",
        email: "email@test.com",
        password: "test1"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
    end
  end
end
