class ProfileOrdersController < ApplicationController
  def show
    @order = current_user.orders.last
  end

  def index

  end
end
