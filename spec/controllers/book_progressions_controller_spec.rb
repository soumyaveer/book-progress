describe BookProgressionsController do
  describe "POST /api/book_progressions" do
    before do
      @user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")
    end

    context "when params are valid" do
      it "creates a new book progression" do
        existing_book = create_book

        request_body = {
          user_id: @user.id,
          book_id: existing_book.id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json, "rack.session" => { user_id: @user.id }

        new_book_progression = BookProgression.find_by(book_id: existing_book.id, user_id: @user.id)

        expect(new_book_progression).to be_present
        expect(new_book_progression.book_id).to eql(existing_book.id)
        expect(new_book_progression.user_id).to eql(@user.id)
      end

      it "returns a response code of 200 when book progression is created successfully" do
        existing_book = create_book

        request_body = {
          user_id: @user.id,
          book_id: existing_book.id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json, "rack.session" => { user_id: @user.id }

        expect(last_response.status).to eql(200)
      end

      it "returns a json response when book progression is created successfully" do
        existing_book = create_book

        request_body = {
          user_id: @user.id,
          book_id: existing_book.id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json, "rack.session" => { user_id: @user.id }

        json_response = JSON.parse(last_response.body).with_indifferent_access

        expect(json_response[:book_id]).to eql(existing_book.id)
        expect(json_response[:user_id]).to eql(@user.id)
        expect(json_response[:current_page]).to eql(0)
      end
    end

    context "when params are invalid" do
      it "returns a response code of 412 when book progression creation fails" do
        wrong_book_id = 500

        request_body = {
          user_id: @user.id,
          book_id: wrong_book_id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json, "rack.session" => { user_id: @user.id }

        expect(last_response.status).to eql(422)
      end

      it "returns json with errors when book progression creation fails" do
        wrong_book_id = 500

        request_body = {
          user_id: @user.id,
          book_id: wrong_book_id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json, "rack.session" => { user_id: @user.id }

        json_response = JSON.parse(last_response.body).with_indifferent_access

        expect(json_response[:errors]).to be_present
      end
    end
  end

  describe "PATCH /api/book_progressions/:id" do
    before do
      @user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")
    end

    context "when params are valid" do
      it "updates the book progression with current page" do
        book = create_book
        book_progression = BookProgression.create!(book: book, user: @user, current_page: 0)

        request_body = {
          book: {
            cover_url: book.cover_url,
            id: book.id,
            title: book.title,
            pages: book.pages
          },
          book_id: book_progression.book.id,
          current_page: 50,
          id: book_progression.id,
          percent_read: book_progression.percent_read,
          user_id: @user.id
        }

        patch "/api/book_progressions/#{book_progression.id}",
              request_body.to_json,
              "rack.session" => { user_id: @user.id }

        json_response = JSON.parse(last_response.body).with_indifferent_access
        expect(last_response.status).to eql(200)

        expect(json_response[:id]).to eql(book_progression.id)
        expect(json_response[:book_id]).to eql(book_progression.book_id)
        expect(json_response[:user_id]).to eql(book_progression.user_id)
        expect(json_response[:current_page]).to eql(50)
      end
    end

    context "when params are invalid" do
      it "returns a response code of 422 on failure to update the book progression with current page" do
        book = create_book
        book_progression = BookProgression.create!(book: book, user: @user, current_page: 0)

        request_body = {
          book: {
            cover_url: book.cover_url,
            id: book.id,
            title: book.title,
            pages: book.pages
          },
          book_id: book.id,
          current_page: "string",
          id: book_progression.id,
          percent_read: book_progression.percent_read,
          user_id: @user.id
        }

        patch "/api/book_progressions/#{book_progression.id}",
              request_body.to_json,
              "rack.session" => { user_id: @user.id }

        expect(last_response.status).to eql(422)
        json_response = JSON.parse(last_response.body).with_indifferent_access

        expect(json_response[:errors]).to be_present
      end
    end
  end

  describe "DELETE /api/book_progressions/:id/delete" do
    before do
      @user = User.create(username: "test-name1", email: "email1@test.com", password: "test1")
    end

    context "on successful delete" do
      it "returns a 200 response code" do
        book = create_book
        book_progression = BookProgression.create!(book: book, user: @user, current_page: 0)

        request_body = {
          book: {
            cover_url: book.cover_url,
            id: book.id,
            title: book.title,
            pages: book.pages
          },
          book_id: book_progression.book.id,
          current_page: 50,
          id: book_progression.id,
          percent_read: book_progression.percent_read,
          user_id: book_progression.user_id
        }

        delete "/api/book_progressions/#{book_progression.id}/delete",
               request_body.to_json,
               "rack.session" => { user_id: @user.id }

        expect(last_response.status).to eql(200)
      end

      it "returns a json response with the deleted book progression" do
        book = create_book
        book_progression = BookProgression.create!(book: book, user: @user, current_page: 0)

        request_body = {
          book: {
            cover_url: book.cover_url,
            id: book.id,
            title: book.title,
            pages: book.pages
          },
          book_id: book_progression.book.id,
          current_page: book_progression.current_page,
          id: book_progression.id,
          percent_read: book_progression.percent_read,
          user_id: book_progression.user_id
        }

        delete "/api/book_progressions/#{book_progression.id}/delete",
               request_body.to_json,
               "rack.session" => { user_id: @user.id }

        deleted_book_progression = BookProgression.find_by(id: book_progression.id)

        expect(deleted_book_progression).to_not be_present

        json_response = JSON.parse(last_response.body).with_indifferent_access
        expect(json_response[:id]).to eql(book_progression.id)
        expect(json_response[:book_id]).to eql(book_progression.book_id)
        expect(json_response[:user_id]).to eql(book_progression.user_id)
      end
    end

    context "on delete failure" do
      it "returns the response code 404 when book progression is not found" do
        book = create_book
        non_existing_book_progress_id = 30

        request_body = {
          book: {
            cover_url: book.cover_url,
            id: book.id,
            title: book.title,
            pages: book.pages
          },
          book_id: 123,
          current_page: 100,
          id: non_existing_book_progress_id,
          percent_read: 20,
          user_id: @user.id
        }

        deleted_book_progression = BookProgression.find_by(id: non_existing_book_progress_id)

        expect(deleted_book_progression).to be_nil
        delete "/api/book_progressions/#{non_existing_book_progress_id}/delete",
               request_body.to_json,
               "rack.session" => { user_id: @user.id }

        expect(last_response.status).to eql(404)
      end
    end
  end
end
