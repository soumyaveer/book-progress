class BookProgressionsController < ApplicationController
  get "/users/:id/book-shelf" do
    erb :index
  end

  get "/api/users/:user_id/book-progressions" do
    user = User.find(params[:user_id])

    json(
      {
        book_progressions: user.book_progressions,
        user: user
      }.as_json
    )
  end

  post "/api/book_progressions" do
    authenticate

    book_progression = BookProgression.new(
      user_id: json_request_body[:user_id],
      book_id: json_request_body[:book_id],
      current_page: 0
    )

    if book_progression.save
      json(book_progression.as_json)
    else
      status(422)

      book_progression_json = book_progression.as_json
      book_progression_json[:errors] = book_progression.errors.full_messages

      json(book_progression_json)
    end
  end

  patch "/api/book_progressions/:id" do
    authenticate

    book_progression = BookProgression.find(json_request_body[:id])
    book_progression.current_page = json_request_body[:current_page]

    if book_progression.save
      json(book_progression.as_json)
    else
      status(422)

      book_progression_json = book_progression.as_json
      book_progression_json[:errors] = book_progression.errors.full_messages

      json(book_progression_json)
    end
  end

  # delete action
  delete "/api/book_progressions/:id/delete" do
    authenticate

    book_progression = BookProgression.find_by(id: json_request_body[:id])

    if book_progression
      book_progression.destroy!
      json(book_progression.as_json)
    else
      status 404
    end
  end
end
