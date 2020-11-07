require 'rails_helper'

describe "As a merchant employee" do
  describe "When I visit a discount edit page" do
    it "I edit a discount and upon submission am taken back to the discount index page" do
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

      visit "/merchant/discounts/#{discount.id}/edit"

      fill_in :min_qty, with: 15

      click_button "Update Discount"

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_content("Minimum Order Quantity: 15")
      expect(page).to have_content("10%")
    end
  end
end
