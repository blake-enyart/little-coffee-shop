class Admin::MerchantsController < ApplicationController
  before_action :error_unless_admin
  def show
    @user_to_be_updated = User.find(params[:id])
  end

  def update
    user_to_be_updated = User.find(params[:id])
    user_to_be_updated.disable_merchant_items
    user_to_be_updated.update(role: 0)
    flash[:notice] = "Merchant #{user_to_be_updated.name} downgraded"
    redirect_to admin_user_path(user_to_be_updated)
  end
end
