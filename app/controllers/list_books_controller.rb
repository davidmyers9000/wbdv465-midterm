class ListBooksController < ApplicationController
  before_action :authorize_user!
  before_action :set_list
  before_action :set_user
  before_action :set_list_book, only: :destroy

  def new
    @books = @list.books
  end

  def edit
  end

  def show
  end

  def destroy
    @list_book.destroy
    redirect_to school_course_path(@course.school, @course)
  end

  def create
    if @list.update(list_book_params)
      redirect_to user_list_path(@list.user, @list)
    else
      render :new
    end
  end

  def index
  end
  
  private

    def set_list
      @list = List.find(params[:list_id])
    end

    def set_list_book
      @list_book = ListBook.find_by(list_id: params[:list_id], book_id: params[:id])
    end

    def set_user
      @user = @list.user
    end

    def list_book_params
      params.require(:list).permit(book_ids: [])
    end

end