class Admin::LabelsController < Admin::BaseController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = Label.all
                   .order(created_at: :desc)
                   .page(params[:page])
  end

  def new
    @label = Label.new
  end

  def edit
  end

  def create
    @label = Label.new(label_params)

    respond_to do |format|
      if @label.save
        flash[:success] = '新しいラベルが作成されました！'
        format.html { redirect_to admin_labels_path }
        format.json { render :show, status: :created, location: admin_labels_path }
      else
        format.html { render :new }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @label.update(label_params)
        flash[:success] = 'ラベルの編集に成功しました！'
        format.html { redirect_to admin_labels_path }
        format.json { render :show, status: :ok, location: admin_labels_path}
      else
        format.html { render :edit }
        format.json { render json: @label.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @label.destroy
    flash[:success] = 'ラベルの削除に成功しました！'
    respond_to do |format|
      format.html { redirect_to admin_labels_path }
      format.json { head :no_content }
    end
  end

  private
    def set_label
      @label = Label.find_by(id: params[:id])
    end

    def label_params
      params.require(:label).permit(:name)
    end

end
