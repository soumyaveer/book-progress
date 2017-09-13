describe BookProgressionsController do
  describe "Index Page" do
    context "when logged in" do
      it 'loads index page' do
        user = User.create(:username => "test-name1", :email => "email1@test.com", :password => "test1")
        book1 = Book.create(title: "book-name1", author: "book-author", pages: 300)
        book2 = Book.create(title: "book-name2", author: "book-author", pages: 500)

        book_progression1 = BookProgression.create(user: user, book: book1, current_page: 100)
        book_progression2 =BookProgression.create(user: user, book: book2, current_page: 0)

        visit '/login'

        fill_in(:username, with: "test-name1")
        fill_in(:password, with: "test1")

        click_button 'Log In'
        visit '/book_progressions'

        expect(page.body).to include(book_progression1.book.title)
        expect(page.body).to include(book_progression2.book.title)
      end
    end

    context "when logged out" do
      it 'redirects the user to login page' do
        get '/book_progressions'
        expect(last_response.location).to include("/login")
      end
    end
  end

  describe "Show Page" do
    context "when logged in" do
      it 'displays the progress details of user\'s book' do
        user = User.create(:username => "test-name1", :email => "email1@test.com", :password => "test1")
        book1 = Book.create(title: "book-name1", author: "book-author", pages: 300)
        book_progression1 = BookProgression.create(user: user, book: book1, current_page: 100)

        visit '/login'

        fill_in(:username, with: "test-name1")
        fill_in(:password, with: "test1")

        click_button 'Log In'
        visit "/book_progressions/#{book_progression1.id}"

        expect(page.body).to include(book_progression1.book.title)
        expect(page.body).to include(book_progression1.book.author)
        expect(page.body).to include("#{book_progression1.book.pages}")
        expect(page.body).to include(book_progression1.current_page.to_s)
        expect(page.body).to include(book_progression1.percent_read.to_s)
        expect(page.body).to include(book_progression1.percent_left.to_s)
      end
    end

    context "when logged out" do
      it 'redirects the user to login page' do
        user = User.create(:username => "test-name1", :email => "email1@test.com", :password => "test1")
        book1 = Book.create(title: "book-name1", author: "book-author", pages: 300)
        book_progression1 = BookProgression.create(user: user, book: book1, current_page: 100)

        get "/book_progressions/#{book_progression1.id}"

        expect(last_response.location).to include("/login")
      end
    end
  end

  describe "new action" do
    context 'logged in' do
      before do
        @user1 = User.create(:username => "test-name1", :email => "email1@test.com", :password => "test1")
        @user2 = User.create(:username => "test-name2", :email => "email2@test.com", :password => "test2")

        @book1 = Book.create(title: "book-name1", author: "book-author", pages: 300)
        visit '/login'

        fill_in(:username, with: "test-name1")
        fill_in(:password, with: "test1")

        click_button 'Log In'
      end

      it 'redirects to create new book page' do
        visit '/book_progressions/new'
        expect(page.status_code).to eql(200)
      end

      it 'allows the creation of new progress' do
        visit '/book_progressions/new'
        fill_in(:title, with: "New Title")
        fill_in(:author, with: "some author")
        fill_in(:pages, with: 300)
        fill_in(:current_page, with: 100)

        click_button 'Submit'

        user = User.find_by(id: @user1.id)
        book = Book.find_by(id: @book1.id)

        expect(user).to be_instance_of(User)
        expect(book).to be_instance_of(Book)
        expect(page.status_code).to eql(200)
      end

      it 'does not let user create a progress in another user\'s account' do
        visit '/book_progressions/new'
        fill_in(:title, with: "New Title")
        fill_in(:author, with: "some author")
        fill_in(:pages, with: 300)
        fill_in(:current_page, with: 100)

        click_button 'Submit'
        logged_in_user = User.find_by(id: @user1.id)
        not_logged_in_user = User.find_by(id: @user2.id)
        book2 = Book.find_by(title: "New Title")
        book_progression = BookProgression.find_by(book_id: book2.id)

        expect(book_progression).to be_instance_of(BookProgression)
        expect(book_progression.user_id).to eq(logged_in_user.id)
        expect(book_progression.user_id).not_to eql(not_logged_in_user.id)
      end

      it 'does not let user create a blank progression' do
        visit '/book_progressions/new'
        fill_in(:title, with: "")
        fill_in(:author, with: "some author")
        fill_in(:pages, with: 300)
        fill_in(:current_page, with: 100)
        click_button 'Submit'

        expect(Book.find_by(title: "")).to eql(nil)
        expect(page.current_path).to eql("/book_progressions/new")
      end
    end

    context 'logged out' do
      it 'redirects the user to login page' do
        get '/book_progressions/new'
        expect(last_response.location).to include("/login")
      end
    end
  end
end
