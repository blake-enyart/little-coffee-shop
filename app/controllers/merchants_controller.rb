class MerchantsController < ApplicationController

  def index
    @merchants = User.where(role: 'merchant')
  end

  def show
    @user = User.find(params[:id])
  end

  def dashboard
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
