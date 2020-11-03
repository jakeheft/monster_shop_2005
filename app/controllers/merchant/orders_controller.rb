class Merchant::OrdersController < Merchant::BaseController
  def show
    @merchant_id = params[:merchant_id]
    @order = Order.find(params["order_id"])
  end
end