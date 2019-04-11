class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant', enabled: true)
    @merchants_disabled = User.where(role: 'merchant', enabled: false) if admin_user?
  end

  def show
    if merchant_user?
      @user = User.find(current_user.id)
      @pending_orders = @user.pending_orders
      @top_five_items_sold = @user.top_five_items_sold
    else
      render file: "/public/404", status: 404
    end
  end
end
