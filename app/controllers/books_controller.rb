class BooksController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def index
    if params[:tag]
      @books = Book.tagged_with(params[:tag])
    else 
      @books = Book.all
    end
  end

  def show
    if current_user
      @user_book = UserBook.where(user: current_user, book: @book).first
      @user_book ||= UserBook.new(user: current_user)
    end

    @reviews = @book.reviews.limit(5)
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @book.destroy
    redirect_to root_url
  end

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :author, :summary, :page_count, :isbn, :tag_list)
    end
end
