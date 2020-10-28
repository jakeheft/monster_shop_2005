class PasswordsController < UserBaseController
  def edit
  end

  def update
    @current_user.assign_attributes(password_params)
    if @current_user.save
      redirect_to '/profile', notice: 'Your password has been changed'
    else
      flash[:error] = @current_user.errors.full_messages.uniq
      redirect_to '/password/edit'
    end
  end

  private

  def password_params 
    params.permit(:password, :password_confirmation)
  end
end
