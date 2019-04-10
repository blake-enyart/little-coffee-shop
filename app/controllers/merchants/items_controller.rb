class Merchants::ItemsController < ApplicationController

  def index
    @merchant = current_user
  end

  def enable_item
    item = Item.find(params[:id])
    item.update(enabled: true)

    flash[:item_enable_success] = "#{item.name} is now available for sale."

    redirect_to dashboard_items_path
  end

  def fulfill_item
    order_item = OrderItem.find(params[:order_item])
    order_item.fulfill_item

    flash[:item_fulfilled_success] = "Item #{order_item.item.name} has been fulfilled successfully."

    order = Order.find(params[:order])
    redirect_to dashboard_order_path(order)
  end

end
