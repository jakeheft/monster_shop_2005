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

  def subtotal(item)
    if apply_discount?(item.id.to_s)
      discount = discount_selection(item.id.to_s, item.merchant).percent
      price = item.price * @contents[item.id.to_s]
      price * (1 - discount/100)
    else
      item.price * @contents[item.id.to_s]
    end
  end

  def total
    # @contents.sum do |item_id,quantity|
    #   Item.find(item_id).price * quantity
    # end
    items = @contents.keys.map do |item_id|
      Item.find(item_id)
    end
    items.sum do |item|
      subtotal(item)
    end
  end

  def apply_discount?(item)
    cart_qty = @contents[item]
    merchant = Merchant.select('merchants.*').joins(:items).where('items.id = ?', item).first
    merchant.discounts.where('min_qty <= ?', cart_qty) != []
  end

  def discount_selection(item, merchant)
    cart_qty = @contents[item]
    merchant.discounts.where('min_qty <= ?', cart_qty).order('percent DESC').first
  end

end
