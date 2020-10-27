class UsersController < ApplicationController

  def new
  end

  def create
    new_user = User.new(user_params)
    if new_user.save
      redirect_to '/profile', notice: "You are now registered and logged in"
    else
      redirect_to '/register', notice: "You are missing required field(s)"
    end
  end

  def show
  end

  private
  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
