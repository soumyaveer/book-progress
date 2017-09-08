class BooksController < ApplicationController
  # index
  get '/books/index' do
    if logged_in?
      @books = current_user.books
      erb :'/books/index'
    else
      redirect '/login'
    end
  end

  #create
  get '/books/new' do
    if logged_in?
      erb :'/books/new'
    else
      redirect '/login'
    end
  end

  post '/books' do
    @book = current_user.books.new(title: params[:title], author: params[:author], pages: params[:pages])
    if @book.save
      @book_progression = BookProgression.new(user_id: current_user.id, book_id: @book.id, current_page: params[:current_page])
      @book_progression.save
      redirect "books/#{@book.id}"
    else
      redirect '/books/new'
    end
  end

  # update
  get '/books/:id/edit' do
    if logged_in?
      @book = Book.find(params[:id])
      @progress = BookProgression.find_by(book_id: params[:id])
      erb :'/books/edit'
    else
      redirect '/login'
    end
  end

  patch '/books/:id' do
    @book = Book.find(params[:id])
    @book.title = params[:title]
    @book.author = params[:author]
    @book.pages = params[:pages].to_i

    if @book.save
      @progress = BookProgression.find_by(book_id: params[:id])
      @progress.current_page = params[:current_page].to_i
      redirect "/books/#{@book.id}"
    else
      redirect "/books/#{@books.id}/edit"
    end
  end
  
  # show
  get '/books/:id' do
    if logged_in?
      @book = Book.find(params[:id])
      @progress = BookProgression.find_by(book_id: params[:id])
      binding.pry
      erb :'/books/show'
    else
      redirect '/login'
    end
  end
end
