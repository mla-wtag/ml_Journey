class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :hide_navbar, only: [:create, :new]

  def index
    @user = User.all
  end

  def create
    @user = User.new(user_params)
    @user.generate_confirmation_token
    if @user.save
      VerificationMailer.confirmation_email(@user).deliver_now
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
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

  def update_role
    if @user.user_role?
      @user.update(role: 'admin_role')
      flash[:alert] = "#{@user.first_name} " + t('alerts.ability_admin_role')
    else @user.admin_role?
      @user.update(role: 'user_role')
      flash[:alert] = "#{@user.first_name} " + t('alerts.ability_user_role')     end
    redirect_to users_path
  end

  def confirm_email
    @user = User.find_by(confirmation_token: params[:confirmation_token])
    if @user&.confirmed_at.present?
      flash[:alert] = t('validations.confirmation_email')
    else
      @user.update(confirmed_at: Time.current, confirmation_token: nil)
    end
    redirect_to root_path
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
end
