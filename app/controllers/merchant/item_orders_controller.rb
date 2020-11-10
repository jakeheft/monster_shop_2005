class Merchant::ItemOrdersController < Merchant::BaseController
  def update
    item_order = ItemOrder.find(params[:itemorder_id])
    order = Order.find(params[:order_id])
    item_order.fulfill
    if item_order.save
      redirect_to "/merchant/orders/#{item_order.order.id}", notice: "#{item_order.item.name} fulfilled"
    end
  end
end
