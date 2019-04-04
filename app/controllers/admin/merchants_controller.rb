class Admin::MerchantsController < ApplicationController

  def show
    @current_merch = User.find(params[:id])
  #   render file: "/public/404", status: 404 unless admin_user?
  end

  def update
    @current_merch = User.find(params[:id])
    @current_merch[:role] = 0
    redirect_to admin_user_path(@current_merch)
  end
end
