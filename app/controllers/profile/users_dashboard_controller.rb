class Profile::UsersDashboardController < Profile::BaseController
  def show; end

  def edit; end

  def update
    @current_user.assign_attributes(user_params)
    if @current_user.save
      redirect_to '/profile', notice: 'Your profile has been updated'
    else
      flash[:error] = @current_user.errors.full_messages.uniq
      redirect_to '/profile/edit'
    end
  end

  private

  def user_params
    params.permit(:name, :address, :city, :state, :zip, :email)
  end
end
