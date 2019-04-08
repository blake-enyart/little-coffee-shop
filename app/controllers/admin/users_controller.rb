class Admin::UsersController < ApplicationController
  before_action :error_unless_admin
  def show
    @user = User.find(params[:id])
  end
  def index
    @users = User.where(role: 0)
  end
end
