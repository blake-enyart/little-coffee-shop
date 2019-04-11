class Merchants::ItemsController < ApplicationController

  def index
    @merchant = current_user
  end

  def new
    @merchant = current_user
    @item = Item.new
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

  def delete_item
    item = Item.find(params[:id])
    item.destroy

    flash[:item_delete_success] = "#{item.name} has been deleted."
    
    redirect_to dashboard_items_path
  end

  def disable_item
    item = Item.find(params[:id])
    item.update(enabled: false)

    flash[:item_disable_success] = "#{item.name} is no longer for sale."

    redirect_to dashboard_items_path
  end
end
