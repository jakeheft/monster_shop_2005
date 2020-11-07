class Discount < ApplicationRecord
    belongs_to :merchant
    has_many :item_orders

    def valid_attributes?
      percent > 0 && percent < 100 && min_qty > 0
    end
end
