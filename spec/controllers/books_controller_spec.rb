describe BooksController do
  before do
    @user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")
  end

  describe "POST /books" do
    context "when params are valid" do
      it "returns the response with the book details if book is already present" do
        existing_book = create_book

        expect {
          post "/api/books", {
            authors: existing_book.authors,
            cover_url: existing_book.cover_url,
            isbn_13: existing_book.isbn_13,
            pages: existing_book.pages,
            rating: existing_book.rating,
            title: existing_book.title,
          }.to_json, "rack.session" => { user_id: @user.id }
        }.to_not change(Book, :count)

        json_response = JSON.parse(last_response.body).with_indifferent_access
        expect_json_response_to_match_book(json_response, existing_book)
      end

      it "creates a new book and returns the response with new book details when book is not found" do
        book_params = book_attributes

        post "/api/books", book_params.to_json, "rack.session" => { user_id: @user.id }

        expect(last_response.status).to eql(200)
        json_response = JSON.parse(last_response.body).with_indifferent_access

        found_book = Book.find_by(isbn_13: book_params[:isbn_13])

        expect_json_response_to_match_book(json_response, found_book)
      end
    end

    context "when params are invalid" do
      it "returns status code 412" do
        book_params = book_attributes

        expect {
          post "/api/books", {
            authors: book_params[:authors],
            cover_url: book_params[:cover_url],
            isbn_13: nil,
            pages: book_params[:pages],
            preview_url: book_params[:preview_url],
            rating: book_params[:rating],
            title: book_params[:title]
          }.to_json, "rack.session" => { user_id: @user.id }
        }.to_not change(Book, :count)

        expect(last_response.status).to eql(422)
        json_response = JSON.parse(last_response.body).with_indifferent_access
        expect(json_response[:errors]).to be_present
        expect(json_response[:errors]).to match_array(["Isbn 13 can't be blank"])
      end
    end

    def expect_json_response_to_match_book(json_response, book)
      expect(json_response[:id]).to eql(book.id)
      expect(json_response[:title]).to eql(book.title)
      expect(json_response[:authors]).to eql(book.authors)
      expect(json_response[:isbn_13]).to eql(book.isbn_13)
    end
  end
end
