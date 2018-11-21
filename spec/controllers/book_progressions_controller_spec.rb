describe BookProgressionsController do
  describe "GET /api/users/:user_id/book_progressions" do
    it "returns book progressions for specified user" do
      user = create_user
      another_user = create_user
      book1 = Book.create(title: "book-name1", author: "book-author", pages: 300)
      book2 = Book.create(title: "book-name2", author: "book-author", pages: 500)

      book_progression_1 = BookProgression.create(user: user, book: book1, current_page: 100)
      book_progression_2 = BookProgression.create(user: user, book: book2, current_page: 200)
      book_progression_3 = BookProgression.create(user: another_user, book: book2, current_page: 200)

      get "/api/users/#{user.id}/book-progressions"
      expect(last_response.status).to eql(200)

      json_response = JSON.parse(last_response.body).deep_symbolize_keys
      expect(json_response.keys).to match_array(%i(book_progressions user))

      expect(json_response.fetch(:book_progressions).size).to eql(2)

      expect(json_response.fetch(:book_progressions).map { |json| json[:id] })
        .to match_array([book_progression_1.id, book_progression_2.id])

      expect(json_response.fetch(:book_progressions).map { |json| json[:book][:id] })
        .to match_array([book1.id, book2.id])

      expect(json_response.fetch(:user).as_json).to eql(user.as_json)
    end
  end
end