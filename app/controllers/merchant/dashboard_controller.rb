class Merchant::DashboardController < Merchant::BaseController
  def show
    @merchant = User.find(session[:user_id]).merchant
  end
end
