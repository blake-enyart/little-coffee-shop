class Merchants::ItemsController < ApplicationController

  def index
    @merchant = current_user
  end

  def new
    # require 'pry'; binding.pry
    @merchant = current_user
    @item = Item.new
  end

  def create
    item = current_user.items.new(item_params)
    if item.image_url == ""
      item.image_url = "https://i.pinimg.com/originals/2a/84/90/2a849069c7f487f71bb6594dffb84e5e.png"
    end
    if item.save
      flash[:success] = "#{item.name} is now saved and available for sale."
      redirect_to dashboard_items_path
    else
      flash[:error] = item.errors.full_messages.join(", ")
      redirect_to new_merchant_item_path
    end
  end

  def enable_item
    item = Item.find(params[:id])
    item.update(enabled: true)

    flash[:item_enable_success] = "#{item.name} is now available for sale."

    redirect_to dashboard_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image_url, :quantity, :price)
  end

end
