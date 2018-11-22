require "rack-flash"

class BookProgressionsController < ApplicationController
  use Rack::Flash

  # index
  get "/book_progressions" do
    authenticate
    @book_progressions = current_user.book_progressions
    erb :'/book_progressions/index'
  end

  # create
  get "/book_progressions/new" do
    authenticate
    erb :'/book_progressions/new'
  end

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

  post "/book_progressions" do
    authenticate
    @book = current_user.books.find_or_create_by(title: params[:title])
    @book.author = params[:author]
    @book.pages = params[:pages]

    if @book.save
      @book_progression = BookProgression.new(
        user_id: current_user.id,
        book_id: @book.id,
        current_page: params[:current_page]
      )
      @book_progression.save
      redirect "book_progressions/#{@book_progression.id}"
    else
      flash[:message] = "Book not added to your Bookshelf. Please check and add again."
      redirect "/book_progressions/new"
    end
  end

  # show
  get "/book_progressions/:id" do
    authenticate
    @book_progression = BookProgression.find(params[:id])
    erb :'/book_progressions/show'
  end

  # update
  get "/book_progressions/:id/edit" do
    authenticate

    if @book_progression = current_user.book_progressions.find_by(id: params[:id])
      erb :'/book_progressions/edit'
    else
      redirect "/book_progressions"
    end
  end

  patch "/book_progressions/:id" do
    authenticate
    @book_progression = current_user.book_progressions.find_by(id: params[:id])

    if @book_progression
      @book = @book_progression.book
      @book.title = params[:title]
      @book.author = params[:author]
      @book.pages = params[:pages].to_i
      @book_progression.current_page = params[:current_page].to_i

      if @book_progression.save && @book.save
        redirect "/book_progressions/#{@book_progression.id}"
      else
        flash[:message] = "Book not edited. Please check and edit again."
        redirect "/book_progressions/#{@book_progression.id}/edit"
      end
    else
      redirect "/book_progressions"
    end
  end

  # delete action
  delete "/book_progressions/:id/delete" do
    authenticate
    @book_progression = BookProgression.find(params[:id])
    @book_progression.delete if @book_progression.user_id == current_user.id
    redirect "/book_progressions"
  end
end
