class Admin::MerchantsController < Admin::BaseController

  def show
    @user = User.find(params[:id])
    redirect_to admin_user_path(@user) if @user.user?
  end

  def update
    merchant = User.find(params[:id])
    if params[:disable]
      merchant.disable_merchant_items
      merchant.update(enabled: false)
      flash[:merchant_disabled] = "#{merchant.name} is now disabled"
      redirect_to merchants_path
    elsif params[:enable]
      merchant.update(enabled: true)
      merchant.enable_merchant_items
      flash[:merchant_enabled] = "#{merchant.name} is now enabled"
      redirect_to merchants_path
    elsif params[:downgrade]
      merchant.disable_merchant_items
      merchant.update(role: 0)
      flash[:notice] = "Merchant #{merchant.name} downgraded"
      redirect_to admin_user_path(merchant)
    end
  end
end
