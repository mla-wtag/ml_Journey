class TasksController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :task, through: :user

  def create
    @task = @user.tasks.new(task_params)
    @task.users = User.where(id: params[:task][:user_ids])
    @task.creator_id = @user.id
    if @task.save
      redirect_to user_tasks_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to user_tasks_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @task.destroy
      flash[:alert] = t('alerts.delete_successful')
    else
      flash[:alert] = t('alerts.delete_failed')
    end
    redirect_to user_tasks_path(@user)
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :date, :status, user_ids: [])
  end
end
