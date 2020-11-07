class Merchant::DiscountsController < Merchant::BaseController
  def index
    @merchant = current_user.merchant
  end

  def new
    # merchant = current_user.merchant
    # # require "pry"; binding.pry
    # @discount = merchant.discounts.new
  end

  def create
    merchant = current_user.merchant
    merchant.discounts.create!(discount_params)
    redirect_to '/merchant/discounts', notice: "Your discount has successfully been created"
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    discount.assign_attributes(discount_params)
    if discount.save
      redirect_to '/merchant/discounts', notice: "Your discount has been updated"
    else
      flash[:error] = @current_user.errors.full_messages.uniq
      redirect_to "/merchant/discounts/#{discount.id}/edit"
    end
  end

  private
  def discount_params
    params.permit(:percent, :min_qty)
  end
end
