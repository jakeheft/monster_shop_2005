class UsersController < ApplicationController

  def new
    @new_user = User.new(user_params)
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      redirect_to '/profile', notice: "You are now registered and logged in"
    elsif @new_user.valid_email == false
      flash[:notice] = "That email address is already in use!"
      render :new
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
