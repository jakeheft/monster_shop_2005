require 'rails_helper'

describe Discount, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :item_orders }
  end

  describe 'instance methods' do
    it '#valid_attributes?' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      merchant_user = bike_shop.users.create!(name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'Bob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 1
      )
      discount_1 = bike_shop.discounts.create(
        percent: -10,
        min_qty: 5
      )
      discount_2 = bike_shop.discounts.create(
        percent: 101,
        min_qty: 5
      )
      discount_3 = bike_shop.discounts.create(
        percent: 10,
        min_qty: 0.5
      )
      discount_4 = bike_shop.discounts.create(
        percent: 10,
        min_qty: 0
      )
      discount_5 = bike_shop.discounts.create(
        percent: 10,
        min_qty: 10
      )

      expect(discount_1.valid_attributes?).to eq(false)
      expect(discount_2.valid_attributes?).to eq(false)
      expect(discount_3.valid_attributes?).to eq(false)
      expect(discount_4.valid_attributes?).to eq(false)
      expect(discount_5.valid_attributes?).to eq(true)
    end
  end
end
