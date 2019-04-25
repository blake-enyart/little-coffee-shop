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

  def update
    @user = User.find(params[:id])
    if @user.update(user_params) #if the changes save
      if user_params[:role] == 'merchant'
        flash[:notice] = "User #{@user.name} upgraded to merchant."
        redirect_to admin_merchant_path(@user)
      end
    end
  end

  def dashboard
    @admin = current_user
    @orders = Order.sort_by_status
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end
end
