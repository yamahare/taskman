class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :require_login
  helper_method :current_user, :logged_in?

  private
    def login(user)
      session[:user_id] = user.id
      current_user
    end

    def logout
      session.delete(:user_id)
      @current_user = nil
    end

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end

    def logged_in?
      current_user
    end

    def require_login
      unless logged_in?
        flash[:danger] = 'ログインをしてください。'
        redirect_to login_path 
      end
    end

end
