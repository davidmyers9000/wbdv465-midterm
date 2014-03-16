class Authors::ReviewsController < ApplicationController
  before_action :authorize_user!,         except: [:index]

  before_action :set_author
  before_action :set_review,              only: [:edit, :update, :destroy]

  before_action :authorize_by_ownership,  only: [:edit, :update, :destroy]
  before_action :ensure_unique_reviewer,  only: [:new, :create]

  def index
    @reviews = @author.reviews
  end

  def new
    @review = @author.reviews.new
  end

  def edit
  end

  def create
    @review = @author.reviews.new(review_params)
    @review.created_by = current_user

    if @review.save
      redirect_to @author, notice: 'Review was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @review.update(review_params)
      redirect_to @author, notice: 'Review was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to @author
  end

  private

    def authorize_by_ownership
      unless is_user_admin? || @review.created_by_id == current_user.id
        redirect_to @author, notice: "You don't have permission to edit this review"
      end
    end

    def ensure_unique_reviewer
      if @author.reviews.where(created_by: current_user).size > 0
        redirect_to @author, notice: "You already reviewed this author."
      end
    end

    def set_author
      @author = Author.find(params[:author_id])
    end

    def set_review
      @review = @author.reviews.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:rating, :content)
    end
end
