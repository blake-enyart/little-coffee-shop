class Merchants::OrdersController < Merchants::BaseController
  def show
    @order = Order.find(params[:id])
    items = @order.items.where(user: current_user)

    @merchant_items = {}

    items.each do |item|
      @merchant_items[item] = @order.order_items.find_by(item_id: item)
    end
  end
end
