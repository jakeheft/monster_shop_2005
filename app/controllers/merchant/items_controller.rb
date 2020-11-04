class Merchant::ItemsController < Merchant::BaseController
  def index
    user = User.find(session[:user_id])
    @items = Merchant.find(user.merchant.id).items
    @merchant = Merchant.find(user.merchant.id)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to merchant_items_path
      flash[:notice] = "New item has been created"
    else
      flash[:error] = @item.errors.full_messages.to_sentence
      render :new
    end
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

  def destroy
    item = Item.find(params[:item_id])
    item.destroy
    redirect_to merchant_items_path
    flash[:notice] = "This item has been deleted"
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :image, :price, :inventory, :merchant_id)
  end
end
