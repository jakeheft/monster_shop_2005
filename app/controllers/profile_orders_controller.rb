class ProfileOrdersController < ApplicationController
  def index

  end

  def show
    @order = current_user.orders.last
  end

  def cancel
    order = Order.find(params[:id])
    order.update(status: 'cancelled')
    order.return_items
    order.item_orders.update(status: "unfulfilled")
    flash[:notice] = "Your order is now cancelled"
    redirect_to profile_orders_path
  end
end
