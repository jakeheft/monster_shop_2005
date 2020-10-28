require 'rails_helper'

describe "As a registered user" do
  describe "When I visit my profile page" do
    it "I see all my profile data except for password" do
      jake = User.create!( name: 'JakeBob',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.com',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 0
                          )
      visit '/login'

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit '/profile'
save_and_open_page
      expect(page).to have_content("Name: #{jake.name}")
      expect(page).to have_content("Address: #{jake.full_address}")
      expect(page).to have_content("Email: #{jake.email}")
      expect(page).to have_link('Edit Profile')
    end
  end
end
