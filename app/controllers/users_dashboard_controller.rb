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

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end
end
