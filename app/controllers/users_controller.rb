class UsersController < ApplicationController
  # before_filter :authentifcate_user!
  # before_filter :admin_only, except => :show

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

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
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

  # def admin_only
  #   unless current_user.admin?
  #     redirect_to :back, :alert => "Access denied."
  #   end
  # end
  def user_params
    params.require(:user).permit(:firstname, :lastname, :employee_id, :date_of_birth, :joining_day, :designation, :profile_picture, :email, :password, :password_confirmation)
  end
end
