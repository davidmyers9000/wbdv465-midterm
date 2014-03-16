module UsersHelper
  include Books::ReviewsHelper

  def can_manage_user?
    current_user && (is_user_admin? || current_user.id == @user.id)
  end

  def is_users_list?
    current_user && (is_user_admin? || current_user.id == @user.id)
  end
end