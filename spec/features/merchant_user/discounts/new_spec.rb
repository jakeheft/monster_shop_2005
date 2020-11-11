require 'rails_helper'

describe "As a merchant employee" do
  describe "When I visit '/merchant/discounts/new'" do
    it "I fill out a form to create a new discount and upon submitting am redirected to the discount index page" do
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

      visit '/merchant/discounts/new'

      fill_in "Percent", with: 10
      fill_in "Minimum Quantity", with: 5

      click_button "Create Discount"

      discount = Discount.last

      expect(current_path).to eq('/merchant/discounts')
      within "#discount-#{discount.id}" do
        expect(page).to have_content(discount.min_qty)
        expect(page).to have_content("10%")
      end
    end

    it "If I enter incorrect attributes, I get an error" do
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

      visit "/merchant/discounts/new"

      fill_in "Minimum Quantity", with: 0
      fill_in "Percent", with: 10

      click_button "Create Discount"

      expect(page).to have_content("Must enter a valid percentage and minimum quantity")

      visit "/merchant/discounts/new"

      fill_in "Minimum Quantity", with: -5
      fill_in "Percent", with: 10

      click_button "Create Discount"

      expect(page).to have_content("Must enter a valid percentage and minimum quantity")

      visit "/merchant/discounts/new"

      fill_in "Minimum Quantity", with: 0.5
      fill_in "Percent", with: 10

      click_button "Create Discount"

      expect(page).to have_content("Must enter a valid percentage and minimum quantity")

      visit "/merchant/discounts/new"

      fill_in "Percent", with: 0
      fill_in "Minimum Quantity", with: 5

      click_button "Create Discount"

      expect(page).to have_content("Must enter a valid percentage and minimum quantity")

      visit "/merchant/discounts/new"

      fill_in "Percent", with: 100
      fill_in "Minimum Quantity", with: 5

      click_button "Create Discount"

      expect(page).to have_content("Must enter a valid percentage and minimum quantity")
    end
  end
end
