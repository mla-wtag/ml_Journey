class UsersController < ApplicationController
  load_and_authorize_resource

  def create
    @user = User.new(user_params)
    if @user.save
      TestMailer.index(@user.email).deliver_now
      redirect_to test_mailer_path
    else
      render :new, status: :unprocessable_entity
    end
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
    @user.destroy
    redirect_to root_path, status: :see_other
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :employee_id, :date_of_birth, :joining_day, :designation, :profile_photo, :email, :role, :password, :password_confirmation)
  end

  def authenticate_user
    unless current_user == current_session_user
      redirect_to root_path
    end
  end

  def test_mailer
  end
end
