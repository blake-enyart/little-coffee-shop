class MerchantsController < ApplicationController

  def index

  end

  def show
    @user = User.find(current_user.id) if merchant_user?
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
