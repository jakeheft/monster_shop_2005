# User Story 38, Admin disables a merchant account
#
# As an admin
# When I visit the admin's merchant index page ('/admin/merchants')
# I see a "disable" button next to any merchants who are not yet disabled
# When I click on the "disable" button
# I am returned to the admin's merchant index page where I see that the merchant's account is now disabled
# And I see a flash message that the merchant's account is now disabled
require 'rails_helper'

describe "As an admin when I visit the admin's merchant index page" do
  describe "I see a 'disable' button next to any merchants who are not yet disabled" do
    it "When I click on the 'disable button, I am returned to the admin's merchant
        index page where I see the merchant account is disabled and flash message" do
        jake = User.create!(name: 'JakeBob',
                            address: '124 Main St',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: '80202',
                            email: 'JBob1234@hotmail.com',
                            password: 'heftybags',
                            password_confirmation: 'heftybags',
                            role: 2)
        @mike = Merchant.create!(name: "Mike's Print Shop",
                                address: '123 Paper Rd.',
                                city: 'Denver',
                                state: 'CO',
                                zip: 80203)
        visit "/login"

        fill_in :email, with: "JBob1234@hotmail.com"
        fill_in :password, with: "heftybags"
        click_button "Login"
    visit "/admin/merchants"
    expect(page).to have_button("Disable")

    click_button "Disable"
    expect(page).to have_content("Merchant Account Is Now Disabled")
    end
  end
end
