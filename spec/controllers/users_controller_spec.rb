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

    it 'redirects user to signup page if email is not present' do
      params = {
        username: "test-name",
        email: "",
        password: "test1"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'redirects user to signup page if email is not in the right format' do
      params = {
        username: "test-name",
        email: "email@",
        password: "test1"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
    end


    it 'redirects user to signup page if password is not present' do
      params = {
        username: "test-name",
        email: "",
        password: "test1"
      }

      post '/signup', params
      expect(last_response.location).to include("/signup")
    end

    it 'redirects to users homepage if the user is already signed in' do
      user = User.create(:username => "test-name", :email => "email@test.com", :password => "test1")
      params = {
        :username => "test-name",
        :email => "email@test.com",
        :password => "test1"
      }
      post '/signup', params
      session = {}
      session[:user_id] = user.id
      get '/signup'
      expect(last_response.location).to include('/homepage')
    end
  end
end
