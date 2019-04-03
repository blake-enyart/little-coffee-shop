class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_reguser?, :merchant_user?
  def current_user
    # @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_reguser?
    current_user && current_user.user?
  end

  def merchant_user?
    current_user && current_user.merchant?
  end

end
