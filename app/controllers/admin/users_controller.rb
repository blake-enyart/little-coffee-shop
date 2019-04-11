class Admin::UsersController < Admin::BaseController

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.where(role: 0)
  end

  def dashboard
    @admin = current_user
    @orders = Order.where(status: 'packaged')
  end
end
