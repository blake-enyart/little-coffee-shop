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

  def disable_item
    item = Item.find(params[:id])
    item.update(enabled: false)

    flash[:item_disable_success] = "#{item.name} is no longer for sale."

    redirect_to dashboard_items_path
  end

end
