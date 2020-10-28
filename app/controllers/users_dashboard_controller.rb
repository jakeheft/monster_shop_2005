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
    @current_user.update!(password_params)
    redirect_to '/profile', notice: 'Your password has been changed'
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end

  def password_params 
    params.permit(:password, :password_confirmation)

  end
end
