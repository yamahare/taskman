class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_login, only: [:index]

  # GET /tasks
  # GET /tasks.json
  def index
    if logged_in?
      @tasks = current_user.tasks.includes(:labels)
                  .like_username(params[:name])
                  .search_with_status(choice_status)
                  .order(sort_column + ' ' + sort_direction  + ' ' + 'NULLS LAST')
                  .page(params[:page])
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = current_user.tasks.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = current_user.tasks.new(task_params)

    respond_to do |format|
      if @task.save
        flash[:success] = '新しいタスクが作成されました！'
        format.html { redirect_to @task }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        flash[:success] = 'タスクの編集に成功しました！'
        format.html { redirect_to @task }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    flash[:success] = 'タスクの削除に成功しました！'
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.includes(:labels).find_by(id: params[:id])
      redirect_to root_path if @task.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :detail, :priority, :end_date, :status, label_ids: [])
    end

    def sort_column
      %w[end_date priority].include?(params[:sort_column]) ? params[:sort_column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:sort_direction]) ? params[:sort_direction] : 'desc'
    end

    def choice_status
      params[:status] if %w[waiting working completed].include?(params[:status])
    end
end
