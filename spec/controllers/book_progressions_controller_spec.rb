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

        post "/api/book_progressions", request_body.to_json

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

        post "/api/book_progressions", request_body.to_json

        expect(last_response.status).to eql(200)
      end

      it "returns a json response when book progression is created successfully" do
        existing_book = create_book

        request_body = {
          user_id: @user.id,
          book_id: existing_book.id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json

        json_response = JSON.parse(last_response.body).with_indifferent_access

        expect(json_response[:book_id]).to eql(existing_book.id)
        expect(json_response[:user_id]).to eql(@user.id)
        expect(json_response[:current_page]).to eql(0)
      end
    end

    context "when params are invalid" do
      # TODO
      it "returns a response code of 412 when book progression creation fails" do
        wrong_book_id = 500

        request_body = {
          user_id: @user.id,
          book_id: wrong_book_id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json

        expect(last_response.status).to eql(412)
      end

      it "returns json with errors when book progression creation fails" do
        wrong_book_id = 500

        request_body = {
          user_id: @user.id,
          book_id: wrong_book_id,
          current_page: 0
        }

        post "/api/book_progressions", request_body.to_json

        json_reponse = JSON.parse(last_reponse.body).with_indifferent_access

        expect(json_reponse[:errors]).to be_present
      end
    end
  end
end