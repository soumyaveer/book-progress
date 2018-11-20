describe UsersController do
  describe "POST /users" do
    context "when params are valid" do
      it "creates a new user and saves it in session as the current user" do
        new_username = "Sam"
        new_email = "samEmail@test.com"
        new_password = "samTest1"

        expect{
          post "/users", {
            username: new_username,
            email: new_email,
            password: new_password
          }.to_json
        }.to change(User, :count)

        expect(last_response.status).to be(200);

        json_response = JSON.parse(last_response.body).with_indifferent_access

        expect(json_response[:id]).to_not be_blank
        expect(json_response[:username]).to eql(new_username)
        expect(json_response[:email]).to eql(new_email)
        expect(last_request.env.fetch('rack.session').key?('user_id')).to eql(true)
        expect(last_request.env.fetch('rack.session').fetch('user_id')).to eql(json_response[:id])
      end
    end

    context "when params are invalid" do
      it "does not create a new user and does not set a current user in session" do
        existing_user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")

        expect {
          post "/users", {
            username: existing_user.username,
            email: existing_user.email,
            password: "something"
          }.to_json
        }.to_not change(User, :count)

        expect(last_request.env.fetch('rack.session').key?('user_id')).to eql(false)
        json_response = JSON.parse(last_response.body).with_indifferent_access
        expect(json_response[:id]).to be_blank
      end

      it "returns errors in JSON response" do
        existing_user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")

        post "/users", {
          username: existing_user.username,
          email: existing_user.email,
          password: "something"
        }.to_json

        expect(last_response.status).to eql(412)
        json_response = JSON.parse(last_response.body).with_indifferent_access

        expect(json_response[:errors]).to match_array(["Email has already been taken", "Username has already been taken"])
      end
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

  describe "GET /api/users" do
    it "returns an array of user records as json" do
      user_a = create_user
      user_b = create_user

      get "/api/users"

      expect(last_response.status).to eql(200)
      json_response = JSON.parse(last_response.body)

      expect(json_response.keys).to match_array(%w(users))
      expect(json_response.fetch("users").size).to eql(2)

      expect_json_response_has_user(json_response, user_a)
      expect_json_response_has_user(json_response, user_b)
    end
  end

  def expect_json_response_has_user(json_response, expected_user)
    actual_user_json = json_response.fetch("users").find { |json| json["id"] == expected_user.id }
    expect(actual_user_json.keys).to match_array(%w(email id username))
    expect(actual_user_json.fetch("email")).to eql(expected_user.email)
    expect(actual_user_json.fetch("username")).to eql(expected_user.username)
  end
end
