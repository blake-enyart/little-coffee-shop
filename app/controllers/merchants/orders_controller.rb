class Merchants::OrdersController < Merchants::BaseController
  def show
    @order = Order.find(params[:id])
    @merchant_items = @order.items.where(user: current_user)
    @merchant_order_items = @order.order_items.where(item_id: @merchant_items)
  end
end
