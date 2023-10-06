class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to user_path(current_user)
  end
end
