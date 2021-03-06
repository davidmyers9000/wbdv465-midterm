class AuthorsController < ApplicationController
  before_action :authorize_admin!, except: [:index, :show]
  before_action :set_author, only: [:show, :edit, :update, :destroy]

  def index
    @authors = Author.all
  end

  def show
    @books    = @author.books
    @genres   = @books.genres
    @reviews  = @author.reviews.limit(2)
  end

  def new
    @author = Author.new
  end

  def edit
  end

  def create
    @author = Author.new(author_params)

    if @author.save
      redirect_to @author, notice: 'Author was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @author.update(author_params)
      redirect_to @author, notice: 'Author was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @author.destroy
    redirect_to authors_url
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end

    def author_params
      params.require(:author).permit(:name, :bio, :picture)
    end
end
