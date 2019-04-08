class Admin::UsersController < ApplicationController
  before_action :error_unless_admin
  def show
  end
  def index
    @users = User.where(role: 0)
  end
end
