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
      User.create(username: "test-name", email: "email@test.com", password: "test1")
      params = {
        username: "test-name",
        password: "test1"
      }

      post '/login', params

      get '/signup'
      expect(last_response.location).to include('/homepage')
    end
  end

  describe "Log In" do
    it 'returns 200 status code if login is successful' do
      get '/login'
      expect(last_response.status).to eql(200)
    end

    it 'redirects the user to homepage if the login is successful' do
      User.create(username: "test-name", email: "email@test.com", password: "test1")
      params = {
        username: "test-name",
        password: "test1"
      }

      post '/login', params
      expect(last_response.status).to eql(302)
      follow_redirect!
      expect(last_response.status).to eql(200)
      expect(last_response.body).to include("My BookShelf")
    end

    it 'redirects the user to login page if login was unsuccessful' do
      User.create(username: "test-name", email: "email@test.com", password: "test1")
      params = {
        username: "some-name",
        password: "test1"
      }

      post '/login', params
      expect(last_response.status).to eql(302)
      follow_redirect!
      expect(last_response.status).to eql(200)
      expect(last_response.body).to include("Please Login!")
    end

    it 'redirects to homepage if user is already logged in' do
      user = User.create(username: "test-name", email: "email@test.com", password: "test1")
      params = {
        username: "test-name",
        password: "test1"
      }

      post '/login', params
      session = {}
      session[:user_id] = user.id
      get '/login'
      expect(last_response.location).to include("/homepage")
    end
  end

  describe "Logout" do
    it 'allows the user to logout if user is logged in' do
      User.create(username: "test-name", email: "email@test.com", password: "test1")
      params = {
        username: "test-name",
        password: "test1"
      }

      post '/login', params
      get '/logout'
      expect(last_response.location).to include("/login")
    end

    it 'doesn\'t let user logout if user is not logged in' do
      get '/logout'
      expect(last_response.location).to include("/")
    end

    it 'redirects to login page if user is not logged in' do
      get '/users/homepage'
      expect(last_response.location).to include("/login")
    end

    it 'redirects to users homepage if user is logged in' do
      User.create(username: "test-name", email: "email@test.com", password: "test1")

      visit '/login'

      fill_in(:username, with: "test-name")
      fill_in(:password, with: "test1")
      click_button 'Log In'
      expect(page.current_path).to eq('/users/homepage')
    end
  end

  describe 'Users Index Page' do
    it 'displays all the members of BookShare when the user is logged in' do
      User.create(username: "test-name1", email: "email1@test.com", password: "test1")
      User.create(username: "test-name2", email: "email2@test.com", password: "test2")
      User.create(username: "test-name3", email: "email3@test.com", password: "test3")
      User.create(username: "test-name", email: "email@test.com", password: "test1")

      params = {
        username: "test-name",
        password: "test1"
      }

      post '/login', params

      get '/users'

      expect(last_response.body).to include("See what others are reading!")
      expect(last_response.body).to include("Test-name1")
      expect(last_response.body).to include("Test-name2")
      expect(last_response.body).to include("Test-name3")
    end

    it "redirects to login page when the user is not logged in" do
      get '/users'
      expect(last_response.location).to include("/login")
    end
  end

  describe "Users Show Page" do
    it 'displays details of users bookshelf' do
      user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")
      book = Book.create(title: "book-name", author: "book-author", pages: 300)
      BookProgression.create(user: user, book: book, current_page: 100)
      get "/users/#{user.slug}"

      expect(last_response.body).to include("book-name")
      expect(last_response.body).to include("33.33 %")
    end
  end
end
