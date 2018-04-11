class TasksController < ApplicationController
  def index
    @tasklists = Task.all
  end

  def show
    @tasklists = Task.find(params[:id])
  end

  def new
    @tasklists = Task.new
  end

  def create
    @tasklists = Task.new(task_params)

    if @tasklists.save
      flash[:success] = 'Task が正常に追加されました'
      redirect_to @tasklists
    else
      flash.now[:danger] = 'Task が追加されませんでした'
      render :new
    end
  end

  def edit
    @tasklists = Task.find(params[:id])
  end

  def update
    @tasklists = Task.find(params[:id])

    if @tasklists.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasklists
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasklists = Task.find(params[:id])
    @tasklists.destroy

    flash[:success] = 'Taskは正常に削除されました'
    redirect_to tasks_url
  end

def task_params
    params.require(:task).permit(:content, :status)
end


end





