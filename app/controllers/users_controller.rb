class UsersController < ApplicationController
  def new
    @new_user = User.new(user_params)
  end

  def create
    @new_user = User.new(user_params)
    if @new_user.save
      session[:user_id] = @new_user.id
      redirect_to '/profile', notice: 'You are now registered and logged in'
    else
      flash[:error] = @new_user.errors.full_messages.uniq
      render :new
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email, :password, :password_confirmation)
  end
end
