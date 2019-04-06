class Admin::MerchantsController < ApplicationController

  def show
    render file: "/public/404", status: 404 unless admin_user?
    @current_user = User.find(params[:id])
  end
  
  def update
    @current_user = User.find(params[:id])
    @current_user.disable_merchant_items if admin_user?
    @current_user.update!(role: 0)
    flash[:notice] = "Merchant downgraded"
    redirect_to admin_user_path(@current_user)
  end
end
