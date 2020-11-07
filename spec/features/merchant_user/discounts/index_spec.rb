require 'rails_helper'

describe "As a merchant employee when I visit the merchant discount index page" do
  describe "I see a link to create a new discount" do
    it "When I click the link I'm take to a new discount form page" do
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
  end
end
