class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    if (!params[:name].present? &&
        !params[:sort_column].present? &&
        !params[:sort_direction].present? &&
        !params[:status].present?)
      cookies.delete :search_name
      cookies.delete :search_status
    end

    if params[:name].present?
      cookies[:search_name] = params[:name]
    end

    if params[:status].present?
      cookies[:search_status] = params[:status]
    end

    @status = cookies[:search_status]
    @search_name_cookie = cookies[:search_name]
    @tasks = Task.like_username(cookies[:search_name])
                 .search_with_status(choice_status)
                 .order(sort_column + ' ' + sort_direction  + ' ' + 'NULLS LAST')
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        flash.now[:success] = '新しいタスクが作成されました！'
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
        flash.now[:success] = 'タスクの編集に成功しました！'
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
    flash.now[:success] = 'タスクの削除に成功しました！'
    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :detail, :priority, :end_date, :status)
    end

    def sort_column
      %w[end_date priority].include?(params[:sort_column]) ? params[:sort_column] : 'created_at'
    end

    def sort_direction
      %w[asc desc].include?(params[:sort_direction]) ? params[:sort_direction] : 'desc'
    end

    def choice_status
      cookies[:search_status] if %w[0 1 2].include?(cookies[:search_status])
    end
end
