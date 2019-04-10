class Admin::UsersController < Admin::BaseController

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.where(role: 0)
  end

  def dashboard
    @admin = current_user
  end

  def update
    user = User.find(params[:id])
    if params[:upgrade]
      user.update(role: 1)
      flash[:user_uprgraded] = "#{user.name} has been upgraded"
      redirect_to admin_merchant_path(user)
    end
  end
end
