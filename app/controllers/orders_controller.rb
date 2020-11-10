class OrdersController < ApplicationController
  def new; end

  def create
    order_params[:user_id] = current_user.id
    order = Order.create(order_params.merge(user_id: current_user.id).merge(status: 'Pending'))
    if order.save
      order.create_item_orders(cart)
      session.delete(:cart)
      redirect_to '/profile/orders', notice: 'Your order has been created'
    else
      flash[:notice] = 'Please complete address form to create an order.'
      render :new
    end
  end

  private

  def order_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
