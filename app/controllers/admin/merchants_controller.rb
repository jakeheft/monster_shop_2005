class Admin::MerchantsController <  Admin::BaseController
  before_action :require_admin

  def index
    @merchants = Merchant.all
  end

  def disable
    merchant = Merchant.find(params[:merchant_id])
    merchant.update(enabled?: false)
    redirect_to '/admin/merchants'
    flash[:notice] = "Merchant Account Is Now Disabled"
  end
end
