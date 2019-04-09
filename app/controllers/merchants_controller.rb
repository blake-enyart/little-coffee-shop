class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant', enabled: true)
    @best_sellers = @merchants.top_three_sellers
    @fastest_sellers = @merchants.fastest_fulfillment
    @slowest_sellers = @merchants.slowest_fulfillment
  end

  def show
    @user = User.find(current_user.id) if merchant_user?
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
