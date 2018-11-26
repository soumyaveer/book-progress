describe BookProgression do
  before do
    @user1 = create_user
    @user2 = create_user
    @book1 = create_book(pages: 500)
    @book2 = create_book(pages: 1000)
    @book_progression1 = BookProgression.create(user: @user1, book: @book1, current_page: 200)
    @book_progression2 = BookProgression.create(user: @user2, book: @book1, current_page: 300)
    @book_progression3 = BookProgression.create(user: @user2, book: @book2, current_page: 950)
  end

  describe "validations" do
    it "returns users reading the book" do
      expect(@book1.users).to match_array([@user1, @user2])
    end

    it "returns books read by user" do
      expect(@user2.books).to match_array([@book1, @book2])
    end

    it "returns the current page of the book read by user" do
      current_pages = []
      @user2.book_progressions.each { |progress| current_pages << progress.current_page }

      expect(@user2.book_progressions).to match_array([@book_progression2, @book_progression3])
      expect(current_pages).to match_array([300, 950])
    end
  end

  describe "percent_read" do
    it "returns the percent read of the book" do
      reading_progress = @book_progression1.percent_read

      expect(reading_progress).to eql(40.0)
    end

    it "returns 0 if user is on page 0" do
      @book_progression1.current_page = 0
      reading_progress = @book_progression1.percent_read

      expect(reading_progress).to eql(0.0)
    end
  end

  describe "percent_left" do
    it "returns the percent left to read of the book" do
      reading_progress = @book_progression1.percent_left

      expect(reading_progress).to eql(60.0)
    end

    it "returns 100 percent left if the user is on page 0" do
      @book_progression1.current_page = 0
      reading_progress = @book_progression1.percent_left

      expect(reading_progress).to eql(100.0)
    end
  end

  describe "as_json" do
    it "returns json attributes when a book is not present" do
      book_progress = BookProgression.new

      expect(book_progress.as_json.symbolize_keys)
        .to eql(
          book_id: nil,
          current_page: nil,
          id: nil,
          percent_read: nil,
          user_id: nil
        )
    end
  end
end
