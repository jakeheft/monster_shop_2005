class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order
  belongs_to :merchant
  belongs_to :discount, optional: true

  def subtotal
    price * quantity
  end

  def items_left
    (self.item.inventory - self.quantity)
  end

  def fulfill
    assign_attributes(status: 'Fulfilled')
    order.order_status
    item.update(inventory: items_left)
  end
end
