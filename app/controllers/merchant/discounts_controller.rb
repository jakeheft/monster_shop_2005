class Merchant::DiscountsController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
  end

  def new
    merchant = current_user.merchant
    @discount = merchant.discounts.new
  end

  def create
    merchant = current_user.merchant
    ### remove 'new' from new_discount_params when all forms on form tags
    discount = merchant.discounts.new(new_discount_params)
    if discount.valid_attributes?
      discount.save
      redirect_to '/merchant/discounts', notice: "Your discount has successfully been created"
    else
      flash[:error] = "Must enter a valid percentage and minimum quantity"
      redirect_to "/merchant/discounts/new"
    end
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    discount.assign_attributes(discount_params)
    if discount.valid_attributes?
      discount.save
      redirect_to '/merchant/discounts', notice: "Your discount has been updated"
    else
      flash[:error] = "Must enter a valid percentage and minimum quantity"
      redirect_to "/merchant/discounts/#{discount.id}/edit"
    end
  end

  def destroy
    discount = Discount.find(params[:id])
    if discount.destroy
      redirect_to '/merchant/discounts', notice: "Discount has been deleted"
    end
  end

  private
  def discount_params
    params.permit(:percent, :min_qty)
  end

  def new_discount_params
    params.require(:discount).permit(:percent, :min_qty)
  end
end
