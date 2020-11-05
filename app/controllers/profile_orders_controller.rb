class ProfileOrdersController < ApplicationController
  def index

  end

  def show
    @order = Order.find(params[:id])
  end

  def cancel
    order = Order.find(params[:id])
    order.update(status: 'Cancelled')
    order.return_items
    order.item_orders.update(status: "Unfulfilled")
    flash[:notice] = "Your order is now cancelled"
    redirect_to profile_orders_path
  end
end
