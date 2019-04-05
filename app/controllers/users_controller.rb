class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def show
    @user = User.find(current_user.id) if current_reguser?
    render file: "/public/404", status: 404 unless current_reguser?
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:alert] = "You are now registered and logged in as #{@user.email}."
      redirect_to profile_path
    elsif @user.errors.keys.include?(:email) &&
          @user.errors.keys.count < 2 &&
          @user.errors.full_messages_for(:email)[0].include?('taken')
      @user.email = nil
      flash[:error] = @user.errors.full_messages_for(:email)[0]
      render :new
    else
      flash[:error] = 'Missing required field(s)'
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update!(update_params)
    flash[:success] = "Your data is updated"

    redirect_to profile_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :street, :city, :state, :zipcode, :email, :password)
  end

  def update_params
    update_params = params.require(:user).permit(:name, :street, :city, :state, :zipcode, :email, :password, :password_confirmation)
    update_params.delete([:password, :password_confirmation])
    update_params
  end
end
