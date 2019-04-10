class OrdersController < ApplicationController

  def index
    @orders = Order.where(user_id: current_user)
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    if params[:cancel_order]
      order = Order.find(params[:id])

      # Return fulfilled items back to the Item inventory
      fulfilled_order_items = order.order_items.where(fulfilled: true)
      fulfilled_order_items.each do |fulfilled_order_item|
        return_quantity = fulfilled_order_item.item.quantity + fulfilled_order_item.quantity
        fulfilled_order_item.item.update(quantity: return_quantity)
      end

      # Update all order_items to fulfilled: false
      order.order_items.update_all(fulfilled: false)

      # Update the order status to 3 aka "cancelled"
      order.update(status: 3)

      flash[:order_cancelled_success] = "Your order id <#{order.id}> has been cancelled successfully."

      redirect_to profile_path
    end
  end
end
