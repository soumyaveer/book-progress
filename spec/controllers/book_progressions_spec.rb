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
end
