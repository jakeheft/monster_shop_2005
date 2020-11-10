class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents
  end

  def add_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] += 1
  end

  def subtract_item(item)
    @contents[item] = 0 if !@contents[item]
    @contents[item] -= 1
  end

  def total_items
    @contents.values.sum
  end

  def items
    item_quantity = {}
    @contents.each do |item_id,quantity|
      item_quantity[Item.find(item_id)] = quantity
    end
    item_quantity
  end

  def discounted_price(item, discount)
    item.price * (1 - discount / 100)
  end

  def subtotal(item)
    if apply_discount?(item)
      discount = discount_selection(item, item.merchant).percent
      discounted_price(item, discount) * @contents[item.id.to_s]
    else
      item.price * @contents[item.id.to_s]
    end
  end

  def total
    items = Item.find(@contents.keys)
    items.sum do |item|
      subtotal(item)
    end
  end

  def apply_discount?(item)
    merchant = Merchant.select('merchants.*').joins(:items).where('items.id = ?', item).first
    merchant.discounts.where('min_qty <= ?', quantity_of(item)) != []
  end

  def discount_selection(item, merchant = item.merchant)
    merchant.discounts.where('min_qty <= ?', quantity_of(item)).order('percent DESC').first
  end

  def quantity_of(item)
    @contents[item.id.to_s]
  end

end
