describe BookProgression do
  describe 'validations' do
    before do
      @user = User.new(username: "Harry Potter",
                       email: "harry_potter@hogwarts.edu",
                       password: "harry1")

      @book = Book.new(title: "Fantastic Beasts and Where to Find Them.",
                       author: "Newt Scamander",
                       pages: 500)

      @book_progression = BookProgression.new(user_id: @user.id, book_id: @book.id, current_page: 100)
    end

    
  end
end
