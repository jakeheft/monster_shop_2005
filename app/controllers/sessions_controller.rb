class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "You are now logged in"
    if user.role == 3
      redirect_to "/admin"
    elsif user.role == 2
      redirect_to "/merchant"
    else
      redirect_to '/profile'
    end
  end
end
