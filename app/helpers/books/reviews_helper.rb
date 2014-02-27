module Books::ReviewsHelper

  def can_manage_review?(review)
    current_user && (is_user_admin? || review.created_by_id == current_user.id)
  end
end
