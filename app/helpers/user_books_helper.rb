module UserBooksHelper

  def is_users_list?
    current_user && current_user.id == @user.id
  end
end