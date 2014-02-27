class UsersController < ApplicationController
  before_action :authorize_admin!,        only: [:index]
  before_action :authorize_creation!,     only: [:new, :create]
  before_action :set_user,                only: [:show, :edit, :update, :destroy]
  before_action :authorize_management!,   only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @books = @user.book_list
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id unless current_user
      redirect_to root_url, notice: 'User was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @user.destroy
    redirect_to users_url
  end

  private

    def authorize_creation!
      unless !current_user || is_user_admin?
        redirect_to root_url, notice: "You cannot access this page."
      end
    end

    def authorize_management!
      unless is_user_admin? || is_user?
        redirect_to root_url, notice: "You cannot access this page."
      end
    end

    def is_user?
      current_user && current_user.id == @user.id
    end

    def set_user
      @user ||= User.find(params[:id])
    end

    def user_params
      attributes = [:email, :password, :password_confirmation]
      attributes << :role if is_user_admin?
      params.require(:user).permit(*attributes)
    end
end
