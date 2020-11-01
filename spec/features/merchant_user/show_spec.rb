require 'rails_helper'

describe "As a merchant employee" do
  describe "When I visit my merchant dashboard" do
    it "I see the name and full address of the merchant I work for" do
      merchant = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      merchant.users.create!(
        name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'JBob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 1
      )
      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"
      visit "/merchant"

      expect(page).to have_content(merchant.name)
      expect(page).to have_content(merchant.full_address)
    end
  end
end
