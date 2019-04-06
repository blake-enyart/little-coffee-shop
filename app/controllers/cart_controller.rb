class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    render file: "/public/404", status: 404 if merchant_user? || admin_user?
    if @cart.empty?
      flash[:cart_empty] = "Your cart is empty."
    end
  end

  def create
    item = Item.find(params[:item_id])
    @cart.add_item(item.id)
    session[:cart] = @cart.contents
    quantity = @cart.count_of(item.id)

    flash[:notice] = "You now have #{pluralize(quantity, "copy")} of #{item.name} in your cart."
    redirect_to items_path
  end

  def destroy
    @cart.contents.clear

    redirect_to cart_path
  end

  def remove_item
    @cart.contents.delete(params[:id]) # Remove item.id from @contents

    redirect_to cart_path
  end

  def increment_item
    item = Item.find(params[:id])

    if @cart.count_of(item.id) < item.quantity # Check there is stock of item available
      @cart.add_item(item.id)
    else
      flash[:out_of_stock] = "You have reached the maximum stock available currently for #{item.name}."
    end

    redirect_to cart_path
  end

  def decrement_item
    item = Item.find(params[:id])

    if @cart.count_of(item.id) < item.quantity
      @cart.deduct_item(item.id)
    end

    redirect_to cart_path
  end
end
