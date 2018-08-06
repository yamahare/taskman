class SessionsController < ApplicationController
  before_action :set_user, only: [:create]
  skip_before_action :require_login, only: [:new, :create]

  def new
  end

  def create
    if @user && @user.authenticate(session_params[:password])
      login(@user)
      flash[:success] = 'ログインに成功したぞ！！！'
      redirect_to user_profile_path(@current_user.username)
    else
      flash[:danger] = 'メールアドレスまたはパスワードが間違っています!!!!'
      redirect_to login_path
    end
    # redirect_to root_path
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
    def session_params
      params.require(:user).permit(:email, :password)
    end

    def set_user
      @user = User.find_by(email: session_params[:email])
    end
end
