class Admin::UsersController < ApplicationController
  before_action :error_unless_admin
  def show
  end

end
