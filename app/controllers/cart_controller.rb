class CartController < ApplicationController

  def index
    render file: "/public/404", status: 404 if merchant_user? || admin_user?
  end

end
