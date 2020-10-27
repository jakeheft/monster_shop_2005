class SessionsController < ApplicationController
  def new
<<<<<<< HEAD
    
  end
end
=======

  end

  def create
    user = User.find_by(email: params[:email])
    session[:user_id] = user.id
    flash[:success] = "You are now logged in"
    if user.role == "admin"
      redirect_to "/admin"
    elsif user.role == "merchant"
      redirect_to "/merchant"
    else
      redirect_to '/profile'
    end
  end
end
>>>>>>> f7959e2214cf5aef0394a2a72ed7b1cd3100c001
