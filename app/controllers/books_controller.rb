class BooksController < ApplicationController
  get "/books/new" do
    erb :'/index'
  end

  post "/api/books" do
    authenticate
    request_body = JSON.parse(request.body.read).with_indifferent_access
    book = Book.find_by(isbn_13: request_body[:isbn_13])

    if book
      json(book.as_json)
    else
      new_book = Book.new(
        authors: request_body[:authors],
        cover_url: request_body[:cover_url],
        isbn_13: request_body[:isbn_13],
        pages: request_body[:page_count].to_i,
        rating: request_body[:rating],
        title: request_body[:title]
      )

      if new_book.save
        json(new_book.as_json)
      else
        status 422

        new_book_json = new_book.as_json
        new_book_json[:errors] = new_book.errors.full_messages

        json(new_book_json)
      end
    end
  end
end
