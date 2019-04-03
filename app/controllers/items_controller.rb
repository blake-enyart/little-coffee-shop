class ItemsController < ApplicationController

  def index
    @items = Item.where(enabled: true)
  end

end
