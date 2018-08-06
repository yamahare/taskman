module UsersHelper
  def user_type(user)
    return '管理者' if user.is_admin?
  end

  def display_user_name(user)
     user.display_name.present? ? user.display_name : user.username
  end
end
