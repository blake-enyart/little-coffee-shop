class ItemsController < ApplicationController

  def index
    @items = Item.where(enabled: true)
    @most_popular = Item.five_most_popular
    @least_popular = Item.five_least_popular
  end

  def show
    @item = Item.find(params[:id])
  end


  def create
    @item = current_user.items.new(item_params)
    if @item.image_url == ""
      @item.image_url = "https://i.pinimg.com/originals/2a/84/90/2a849069c7f487f71bb6594dffb84e5e.png"
    end
    if @item.save
      flash[:success] = "#{@item.name} is now saved and available for sale."
      redirect_to dashboard_items_path
    else
      flash[:error] = @item.errors.full_messages.join(", ")
      render :"/merchants/items/new"
    end
  end

    private

  def item_params
    params.require(:item).permit(:name, :description, :image_url, :quantity, :price)
  end

end
