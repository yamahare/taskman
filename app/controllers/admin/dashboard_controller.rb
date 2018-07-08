# ユーザコントローラーメソッド
class Admin::DashboardController < Admin::BaseController
  skip_before_action :require_login, only: [:new, :create]

  # GET /users
  # GET /users.json
  def index
  end

end
