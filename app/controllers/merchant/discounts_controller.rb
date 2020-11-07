class Merchant::DiscountsController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
  end

  def new
    merchant = current_user.merchant
    @discount = merchant.Discount.new
  end
end
