class ProfileOrdersController < ApplicationController
  def show
    @order = current_user.orders
  end
end
