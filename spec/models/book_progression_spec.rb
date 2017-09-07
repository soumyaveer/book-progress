describe BookProgression do
  describe 'validations' do
    before do
      @user1 = User.create(username: "Harry Potter",
                       email: "harry_potter@hogwarts.edu",
                       password: "harry1")

      @user2 = User.create(username: "Hermoine Granger",
                          email: "hermoine_granger@hogwarts.edu",
                          password: "smartwitch@1")

      @book1 = Book.create(title: "Fantastic Beasts and Where to Find Them.",
                       author: "Newt Scamander",
                       pages: 500)

      @book2 = Book.create(title: "A History of Magic",
                          author: "Bathilda Bagshot",
                          pages: 1000)

      @book_progression1 = BookProgression.create(user_id: @user1.id, book_id: @book1.id, current_page: 100)
      @book_progression1 = BookProgression.create(user_id: @user2.id, book_id: @book1.id, current_page: 100)
      @book_progression1 = BookProgression.create(user_id: @user2.id, book_id: @book2.id, current_page: 100)


    end

    it 'returns users reading the book' do
      expect(@book.users).to match_array([@user1 ,@user2])
    end

    it 'returns books read by user' do
      expect(@user2.books).to match_array([@book1, @book2])
    end
  end
end
