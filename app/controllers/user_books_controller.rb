class UserBooksController < ApplicationController
  before_action :set_user
  before_action :set_book, only: [:update, :destroy]

  def create
    @book = Book.find(params[:user_book][:book_id])

    book_params = params.require(:user_book).permit(:book_id, :status)
    book_params[:user_id] = @user.id

    @user_book = UserBook.new(book_params)

    if @user_book.save
      redirect_to user_path(@user), notice: "Book added to list."
    else
      redirect_to @book, error: "Something went wrong! Book could not be added to your list"
    end
  end

  def update
    if @user_book.update(status: params[:user_book][:status])
      redirect_to user_path(@user), notice: "Book status updated."
    else
      redirect_to user_path(@user), error: "Book status failed to update!"
    end
  end

  def destroy
    @user_book.destroy
    redirect_to user_path(@user), notice: "Book removed from list."
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_book
      @book = Book.find(params[:id])
      @user_book = UserBook.find_by(user: @user, book: @book)
    end

end