class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant', enabled: true)
    @merchants_disbled = User.where(role: 'merchant', enabled: false) if admin_user?
  end

  def show
    @user = User.find(current_user.id) if merchant_user?
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
