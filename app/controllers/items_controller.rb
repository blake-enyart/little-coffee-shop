class ItemsController < ApplicationController

  def index
    @items = Item.where(enabled: true)
    @most_popular = Item.five_most_popular
    @least_popular = Item.five_least_popular
  end

  def show
    @item = Item.find(params[:id])
  end

end
