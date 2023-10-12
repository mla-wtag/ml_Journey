class ApplicationController < ActionController::Base
  include ApplicationHelper
  helper_method :current_user

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = t('alerts.not_permitted')
    redirect_to user_path(current_user)
  end

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end
end
