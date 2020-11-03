class Merchant::ItemsController < Merchant::BaseController
  def index
    @items = Merchant.find(params["merchant_id"]).items
  end
end
