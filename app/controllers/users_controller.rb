# ユーザコントローラーメソッド
class UsersController < ApplicationController
  before_action :set_user_from_username, only: %i[show]
  skip_before_action :require_login, only: %i[new create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /settings/profile
  def edit
    @user = @current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        login(@user)
        flash[:success] = 'ユーザの登録が完了しました。'
        format.html { redirect_to user_profile_path(@current_user.username) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @current_user.update(user_params)
        flash[:success] = 'ユーザ編集完了'
        format.html { redirect_to user_profile_path(@current_user.username) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user_from_username
    @user = User.find_by(username: params[:username]) || render_404
  end

  def user_params
    params.fetch(:user).permit(:username, :display_name, :email, :password, :password_confirmation)
  end

  def render_404
    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

end
