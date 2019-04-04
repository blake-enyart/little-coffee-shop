class Admin::UsersController < ApplicationController

  def show
    binding.pry
    render file: "/public/404", status: 404 unless admin_user?
  end

end
