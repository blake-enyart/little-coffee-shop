class MerchantsController < ApplicationController

  def index

  end

  def dashboard
    render file: "/public/404", status: 404 unless merchant_user?
  end
end
