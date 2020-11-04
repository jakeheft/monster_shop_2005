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
  def disable_merchant
    self.update(enabled?: false)
    self.items.update(active?: false)
  end

  def enable_merchant
    self.update(enabled?: true)
    self.items.update(active?: true)
  end
end
