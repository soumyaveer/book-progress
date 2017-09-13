class BookProgressionsController < ApplicationController
  # index
  get '/book_progressions' do
    if logged_in?
      @book_progressions = current_user.book_progressions
      erb :'/book_progressions/index'
    else
      redirect '/login'
    end
  end

  # create
  get '/book_progressions/new' do
    if logged_in?
      erb :'/book_progressions/new'
    else
      redirect '/login'
    end
  end

  post '/book_progressions' do
    @book = current_user.books.find_or_create_by(title: params[:title])
    @book.author = params[:author]
    @book.pages = params[:pages]

    if @book.save
      @book_progression = BookProgression.new(user_id: current_user.id, book_id: @book.id, current_page: params[:current_page])
      @book_progression.save
      redirect "book_progressions/#{@book_progression.id}"
    else
      redirect '/book_progressions/new'
    end
  end

  # show
  get '/book_progressions/:id' do
    if logged_in?
      @book_progression = BookProgression.find(params[:id])
      erb :'/book_progressions/show'
    else
      redirect '/login'
    end
  end

  # update
  get '/book_progressions/:id/edit' do
    if logged_in?
      @book_progression = BookProgression.find(params[:id])
      erb :'/book_progressions/edit'
    else
      redirect '/login'
    end
  end

  patch '/book_progressions/:id' do
    @book_progression = BookProgression.find(params[:id])
    @book = Book.find(@book_progression.book_id)
    @book.title = params[:title]
    @book.author = params[:author]
    @book.pages = params[:pages].to_i
    @book_progression.current_page = params[:current_page].to_i

    if @book_progression.save && @book.save
      redirect "/book_progressions/#{@book_progression.id}"
    else
      redirect "/book_progressions/#{@book_progression.id}/edit"
    end
  end

  # delete action
  delete '/book_progressions/:id/delete' do
    if logged_in?
      @book_progression = BookProgression.find(params[:id])
      if @book_progression.user_id == current_user.id
        @book_progression.delete
        redirect '/book_progressions'
      end
    else
      redirect '/login'
    end
  end
end
