# frozen_string_literal: true

class OrdersController < ApplicationController
  def new; end

  def create
    order_params[:user_id] = current_user.id
    order = Order.create(order_params.merge(user_id: current_user.id).merge(status: 'Pending'))
    if order.save
      order.create_item_orders(cart)
      # cart.items.each do |item, quantity|
        # THIS is where I think you'll change each item_order price if it has a discount applied
        # order.item_orders.create({ item: item,
        #                            quantity: quantity,
        #                            price: item.price, #create discount_price method and run a conditional for each item to know whether to apply price or discount_price
        #                            merchant_id: item.merchant.id,
        #                            status: "Pending" })
      # end
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
