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

#   User Story 39, Disabled Merchant Item's are inactive
#
  describe  "As an admin, when I visit the merchant index page"  do
    describe "And I click on the 'disable' button for an enabled merchant" do
      it "Then all of that merchant's items should be deactivated" do
        jake = User.create!(name: 'JakeBob',
                            address: '124 Main St',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: '80202',
                            email: 'JBob1234@hotmail.com',
                            password: 'heftybags',
                            password_confirmation: 'heftybags',
                            role: 2)
        mike = Merchant.create!(name: "Mike's Print Shop",
                                address: '123 Paper Rd.',
                                city: 'Denver',
                                state: 'CO',
                                zip: 80203)
        pull_toy = mike.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
        dog_bone = mike.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)

        visit "/login"

        fill_in :email, with: "JBob1234@hotmail.com"
        fill_in :password, with: "heftybags"
        click_button "Login"

        visit "/admin/merchants"
        click_button "Disable"

        expected = mike.items.all? {|item| item.active? == false }
        expect(expected).to eq(true)
      end
    end
  end
end
