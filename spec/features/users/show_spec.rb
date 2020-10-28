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

      expect(page).to have_content("Name: #{jake.name}")
      expect(page).to have_content("Address: #{jake.full_address}")
      expect(page).to have_content("Email: #{jake.email}")
      expect(page).to have_link('Edit Profile')
    end

    it "I see a link to edit my profile data and when I click the link I'm taken to
    a page to edit my profile" do
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

      click_link('Edit Profile')
      expect(current_path).to eq('/profile/edit')
    end

     it "I click the link to change password and I'm taken to a page to 
     edit my password with a form with fields for new password and confirmation" do
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

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'

      visit '/profile'

      click_link('Edit Password')
      expect(current_path).to eq('/profile/password')
    end
  end
end
