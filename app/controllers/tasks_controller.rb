class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy, :edit, :update, :show]
  
  def index
     if logged_in?
      @user = current_user
      @tasklist = current_user.tasks.build  # form_for 用
      @tasklists = current_user.tasks.order('created_at DESC').page(params[:page])
     end
  end

  def show
    @tasklists = Task.find(params[:id])
  end

  def new
    @tasklists = Task.new
  end

  def create
    @tasklists = current_user.tasks.build(task_params)
    if @tasklists.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @tasklists = current_user.tasklists.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
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


private
 
def correct_user
    @tasklists = current_user.tasks.find_by(id: params[:id])
    unless @tasklists
      redirect_to root_url
    end
end


end





