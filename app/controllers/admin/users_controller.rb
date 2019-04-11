class Admin::UsersController < Admin::BaseController

  def show
    @user = User.find(params[:id])
    if @user.merchant?
      redirect_to admin_merchant_path(@user)
    end
  end

  def index
    @users = User.where(role: 0)
  end

  def dashboard
    @admin = current_user
  end
end
