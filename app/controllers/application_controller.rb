class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user, :current_reguser?, :merchant_user?, :admin_user?
  before_action :set_cart
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_reguser?
    current_user && current_user.user?
  end

  def merchant_user?
    current_user && current_user.merchant?
  end

  def admin_user?
    current_user && current_user.admin?
  end

  def set_cart
    @cart ||= Cart.new(session[:cart])
  end

  def error_unless_admin
    render file: "/public/404", status: 404 unless admin_user?
  end

end
