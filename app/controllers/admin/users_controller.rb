class Admin::UsersController < ApplicationController
  before_action :pdne_unless_admin
  def show
  end

end
