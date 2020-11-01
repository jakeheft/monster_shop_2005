class Admin::ProfileOrdersController < Admin::BaseController
  def update
    order = Order.find(params[:order_id])
    order.update!(status: "Shipped")
    
    redirect_to "/admin"
  end
end