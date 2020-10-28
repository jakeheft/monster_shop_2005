class UsersDashboardController < UserBaseController
  def show
  end

  def edit
  end

  def update 
    user = User.find_by(email: params[:email])
    user.update!(user_params)
    redirect_to '/profile', notice: 'Your profile has been updated'
  end

  def password
  end

  def password_update
    @current_user.assign_attributes(password_params)
    if @current_user.save
      redirect_to '/profile', notice: 'Your password has been changed'
    else
      flash[:error] = @current_user.errors.full_messages.uniq
      redirect_to '/profile/password'
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end

  def password_params 
    params.permit(:password, :password_confirmation)

  end
end
