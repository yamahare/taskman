class Admin::BaseController < ApplicationController
  layout 'admin'

  protect_from_forgery with: :exception
  before_action :require_admin

  private
    def require_admin
      unless is_admin?
        flash[:danger] = '管理者でないものはここを通さん！！！'
        redirect_to root_path
      end
    end


end
