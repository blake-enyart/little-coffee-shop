class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant', enabled: true)
  end

  def show

  end

  def dashboard
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
