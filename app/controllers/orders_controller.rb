class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(status: 'shipped')
    redirect_to admin_dashboard_path(current_user)
  end
end
