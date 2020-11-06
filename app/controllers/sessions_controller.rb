# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    if current_user
      if current_user.merchant?
        redirect_to '/merchant', notice: 'You are already logged in'
      elsif current_user.admin?
        redirect_to '/admin', notice: 'You are already logged in'
      else
        redirect_to '/profile', notice: 'You are already logged in'
      end
    end
  end

  def create
    user = User.find_by(email: params[:email])
    if !user
      flash[:error] = 'Username and/or password is incorrect'
      render :new
    elsif user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are now logged in'
      if user.admin?
        redirect_to '/admin'
      elsif user.merchant?
        redirect_to '/merchant'
      else
        redirect_to '/profile'
      end
    else
      flash[:error] = 'Username and/or password is incorrect'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:cart].clear
    flash[:success] = 'You have successfully logged out'
    redirect_to '/'
  end
end
