class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant', enabled: true)
  end

  def show

  end

  def show
    @user = User.find(current_user.id) if merchant_user?
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
