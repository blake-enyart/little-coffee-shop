class MerchantsController < ApplicationController

  def index

  end

  def show
    if merchant_user?
      @user = User.find(current_user.id)
      @pending_orders = @user.pending_orders
    else
      render file: "/public/404", status: 404
    end
  end
end
