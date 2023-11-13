class GoalsController < ApplicationController
  load_and_authorize_resource :user
  load_and_authorize_resource :goal, through: :user

  def index
    @goal = @user.goals
  end

  def create
    if @goal.save
      redirect_to user_goals_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @goal.update(goal_params)
      redirect_to user_goal_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @goal.destroy
      flash[:alert] = t('alerts.delete_successful')
    else
      flash[:alert] = t('alerts.delete_failed')
    end
    redirect_to user_goals_path(@user)
  end

  private

  def goal_params
    params.require(:goal).permit(:title, :description, :date, :status)
  end
end
