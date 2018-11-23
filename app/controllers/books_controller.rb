class BooksController < ApplicationController
  get "/books/new" do
    erb :'/index'
  end
end
