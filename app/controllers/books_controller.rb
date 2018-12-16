class BooksController < ApplicationController
  get "/books/new" do
    erb :'/index'
  end

  post "/api/books" do
    authenticate

    book = Book.find_by(isbn_13: json_request_body[:isbn_13])

    if book
      json(book.as_json)
    else
      new_book = Book.new(
        authors: json_request_body[:authors],
        cover_url: json_request_body[:cover_url],
        isbn_13: json_request_body[:isbn_13],
        pages: json_request_body[:page_count].to_i,
        preview_url: json_request_body[:preview_url],
        rating: json_request_body[:rating],
        title: json_request_body[:title]
      )

      if new_book.save
        json(new_book.as_json)
      else
        status(422)

        new_book_json = new_book.as_json
        new_book_json[:errors] = new_book.errors.full_messages

        json(new_book_json)
      end
    end
  end
end
