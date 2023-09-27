class UserSessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      if @user.confirmed?
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        flash[:alert] = t('validations.login_invalid_confirmation')
        redirect_to root_path
      end
    else
      flash[:alert] = t('validations.login_invalid_validation')
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
