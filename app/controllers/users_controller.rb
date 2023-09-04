class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  def user_params
    params.require(:user).permit(:firstname, :lastname, :employee_id, :date_of_birth, :joining_day, :designation, :profile_picture, :email)
  end
end
