class Discount < ApplicationRecord
    belongs_to :merchant
    has_many :item_orders
end
