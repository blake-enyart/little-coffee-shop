class Merchants::ItemsController < ApplicationController

  def index
    @merchant = current_user
  end

end
