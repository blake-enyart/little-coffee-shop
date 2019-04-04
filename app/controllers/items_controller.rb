class ItemsController < ApplicationController

  def index
    @items = Item.where(enabled: true)
  end

  def show
    @item = Item.find(params[:id])
  end

end
