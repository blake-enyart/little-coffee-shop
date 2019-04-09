class Merchants::BaseController < ApplicationController
  before_action :require_merchant

  private

  def require_merchant
     render file: "/public/404", status: 404 unless merchant_user?
  end
end
