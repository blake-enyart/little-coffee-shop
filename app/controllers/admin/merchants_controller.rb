class Admin::MerchantsController < ApplicationController

  def show
    @current_merch = User.find(params[:id])
  #   render file: "/public/404", status: 404 unless admin_user?
  end

  def edit
    binding.pry
  end
end
