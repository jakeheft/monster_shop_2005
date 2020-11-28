class Profile::OrdersController < Profile::BaseController
  def index; end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    order = Order.find(params[:id])
    order.cancel_order
    flash[:notice] = 'Your order is now cancelled'
    redirect_to profile_orders_path
  end
end
