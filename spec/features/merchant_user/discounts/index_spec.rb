require 'rails_helper'

describe "As a merchant employee" do
  describe "When I visit the merchant discount index page" do
    it "I click a link to create a new discount and I'm taken to a new discount form page" do
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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

      visit "/merchant/discounts"

      click_link "Create A New Bulk Discount"

      expect(current_path).to eq('/merchant/discounts/new')
    end

    it "I click on a link to edit an existing discount I'm taken to an edit form" do
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
      discount = bike_shop.discounts.create(
        percent: 10,
        min_qty: 10
      )
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(merchant_user)

      visit "/merchant/discounts"

      click_button "Edit Discount"

      expect(current_path).to eq("/merchant/discounts/#{discount.id}/edit")
    end
  end
end
