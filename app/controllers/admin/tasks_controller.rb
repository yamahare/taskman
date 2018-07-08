class Admin::TasksController < Admin::BaseController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.joins(:user).select("tasks.*, users.id AS user_id, users.name AS user_name")
                 .order(created_at: :desc)
                 .page(params[:page])
  end

end
