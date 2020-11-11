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
    price_of(item) * @contents[item.id.to_s]
  end

  def price_of(item)
    if discount_selection(item) == nil
      item.price
    else
      (1 - discount_selection(item).percent / 100) * item.price
    end
  end

  def total
    items = Item.where(id: @contents.keys)
    items.sum do |item|
      subtotal(item)
    end
  end

  def discount_selection(item)
    item.merchant.discounts.where('min_qty <= ?', quantity_of(item)).order('percent DESC').first
  end

  def quantity_of(item)
    @contents[item.id.to_s]
  end
end
