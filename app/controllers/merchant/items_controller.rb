class Merchant::ItemsController < Merchant::BaseController
  def index
    user = User.find(session[:user_id])
    @items = Merchant.find(user.merchant.id).items
    @merchant = Merchant.find(user.merchant.id)
  end

  def deactivate
    item = Item.find(params[:item_id])
    item.update(active?: false)
    redirect_to merchant_items_path
    flash[:notice] = "This item is no longer for sale"
  
  end
  def activate
    item = Item.find(params[:item_id])
    item.update(active?: true)
    redirect_to merchant_items_path
    flash[:notice] = "This item is now available for sale"
  end
end
