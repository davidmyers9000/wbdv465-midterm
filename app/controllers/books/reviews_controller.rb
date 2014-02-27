class Books::ReviewsController < ApplicationController
  before_action :authorize_user!,         except: [:index]

  before_action :set_book
  before_action :set_review,              only: [:edit, :update, :destroy]

  before_action :authorize_by_ownership,  only: [:edit, :update, :destroy]
  before_action :ensure_unique_reviewer,  only: [:new, :create]

  def index
    @reviews = @book.reviews
  end

  def new
    @review = @book.reviews.new
  end

  def edit
  end

  def create
    @review = @book.reviews.new(review_params)
    @review.created_by = current_user

    if @review.save
      redirect_to @book, notice: 'Review was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @book, notice: 'Review was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to @book
  end

  private

    def authorize_by_ownership
      unless is_user_admin? || @review.created_by_id == current_user.id
        redirect_to @book, notice: "You don't have permission to edit this review"
      end
    end

    def ensure_unique_reviewer
      if @book.reviews.where(created_by: current_user).size > 0
        redirect_to @book, notice: "You already reviewed this book."
      end
    end

    def set_book
      @book = Book.find(params[:book_id])
    end

    def set_review
      @review = @book.reviews.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :content)
    end
end
