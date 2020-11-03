class Merchant <ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :item_orders, through: :items
  has_many :users, -> { where role: :merchant }
  has_many :orders, through: :items

  validates_presence_of :name,
                        :address,
                        :city,
                        :state,
                        :zip


  def no_orders?
    item_orders.empty?
  end

  def item_count
    items.count
  end

  def average_item_price
    items.average(:price)
  end

  def distinct_cities
    item_orders.distinct.joins(:order).pluck(:city)
  end

  def pending_orders
    orders.where(status: 'Pending').distinct
  end

  def item_qty
    item_orders.where(status: 'Pending').sum(:quantity)
    # require "pry"; binding.pry
    # orders.joins(:item_orders).select('item_orders.*, sum(item_orders.quantity) as total_qty').where(status: 'Pending').group('item_orders.id').distinct#.pluck('total_qty')
    # pending_orders.map do |order|
    #   order.items.sum do |item|
    #     require "pry"; binding.pry
    #     item_order.quantity
    #   end
    # end.pop
  end
end
