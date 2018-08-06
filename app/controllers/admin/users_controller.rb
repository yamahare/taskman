# ユーザコントローラーメソッド
class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  # GET /users.json
  def index
    task_counts = Task.group(:user_id).select("user_id, COUNT(id) AS task_num").to_sql
    @users = User.joins("LEFT JOIN (#{task_counts}) task_data ON users.id = task_data.user_id")
                 .select("users.*, task_data.task_num AS task_num")
                 .order(created_at: :desc)
                 .page(params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @tasks = @user.tasks.order(created_at: :desc)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        flash[:success] = 'ユーザの登録が完了しました。'
        format.html { redirect_to admin_user_path(@user) }
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
      if @user.update(user_params)
        flash[:success] = 'ユーザ編集完了'
        format.html { redirect_to admin_user_path(@user) }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to admin_users_url, notice: '削除成功' }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_users_url, notice: '削除に失敗しました。' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.fetch(:user).permit(:display_name, :username, :email, :is_admin, :password, :password_confirmation)
  end
end
