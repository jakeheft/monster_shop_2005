class CartController < CartBaseController
  def add_item
    item = Item.find(params[:item_id])
    cart.add_item(item.id.to_s)
    flash[:success] = "#{item.name} was successfully added to your cart"
    redirect_to "/items"
  end

  def show
    @items = cart.items
  end

  def empty
    session.delete(:cart)
    redirect_to '/cart'
  end

  def remove_item
    session[:cart].delete(params[:item_id])
    redirect_to '/cart'
  end

  def modify_quantity
    item = Item.find(params[:item_id])

    if params[:operation] == "add"
      if item.inventory > session[:cart][item.id.to_s]
        cart.add_item(item.id.to_s)
        flash[:success] = "Another #{item.name} was successfully added to your cart"
        flash[:notice] = "A bulk discount has been applied to #{item.name}!" if cart.item_discount(item) != 0
        redirect_to "/cart"
      else
        flash[:notice] = "Not Enough Inventory for #{item.name}"
        redirect_to "/cart"
      end
    elsif params[:operation] == "subtract"
      if session[:cart][item.id.to_s] > 1
        cart.subtract_item(item.id.to_s)
        flash[:success] = "A #{item.name} was successfully removed from your cart"
        flash[:notice] = "A bulk discount has been applied to #{item.name}!" if cart.item_discount(item) != 0

        redirect_to "/cart"
      else
        session[:cart].delete(params[:item_id])
        flash[:success] = "#{item.name} was successfully removed from your cart"
        redirect_to '/cart'
      end
    end
  end
end
