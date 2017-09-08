class BooksController < ApplicationController
  get '/books' do
    erb :index
  end
end
