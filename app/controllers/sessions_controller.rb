class SessionsController < ApplicationController
  def new
<<<<<<< Updated upstream
<<<<<<< Updated upstream
<<<<<<< HEAD
    
=======

=======

  end

  def create
    user = User.find_by(email: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.name}!"
      redirect_to '/'
    else
      flash.now[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = 'You have successfully logged out!'
    redirect_to '/'
>>>>>>> Stashed changes
  end

  def create
    user = User.find_by(email: params[:username])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Logged in as #{user.name}!"
      redirect_to '/'
    else
      flash.now[:error] = "Sorry, your credentials are bad."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash.now[:success] = 'You have successfully logged out!'
    redirect_to '/'
>>>>>>> Stashed changes
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
