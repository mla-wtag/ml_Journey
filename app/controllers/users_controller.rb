class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :employee_id, :date_of_birth, :joining_day, :designation, :profile_picture, :email, :password, :password_confirmation)
  end

  def current_user
    @current_user ||= User.find(params[:id])
  end

  def authenticate_user
    unless current_user == current_session_user
      redirect_to root_path
    end
  end
end
