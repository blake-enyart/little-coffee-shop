class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    render file: "/public/404", status: 404 if merchant_user? || admin_user?
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    quantity = @cart.count_of(item.id)

    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart."
    redirect_to items_path
  end

end
