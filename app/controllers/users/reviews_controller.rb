class Users::ReviewsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @book_reviews = @user.reviews.for_books
    @author_reviews = @user.reviews.for_authors
  end

end