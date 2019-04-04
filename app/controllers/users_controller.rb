class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show

  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:alert] = "You are now registered and logged in as #{@user.email}."
      redirect_to profile_path
    else
      flash[:error] = 'Missing required field(s)'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :street, :city, :state, :zipcode, :email, :password)
  end
end
