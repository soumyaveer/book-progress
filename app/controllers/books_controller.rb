class BooksController < ApplicationController
  # index
  get '/books/index' do
    if logged_in?
      # user = User.find(session[:user_id])
      @books = current_user.books
      erb :'/books/index'
    else
      redirect '/login'
    end
  end

  # show
  get '/books/:id' do
    if logged_in?
      @book = Book.find(params[:id])
      @progress = BookProgression.find_by(book_id: params[:id])
      erb :'/books/show'
    else
      redirect '/login'
    end
  end

  #create
  

end
