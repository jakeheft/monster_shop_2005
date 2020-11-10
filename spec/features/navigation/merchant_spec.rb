require 'rails_helper'

describe 'As a merchant employee' do
  describe 'I see the same links as a regular user' do
    it 'Plus the following link: a link to my merchant dashboard ("/merchant")' do
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      jake = bike_shop.users.create!(name: 'JakeBob',
                          address: '124 Main St',
                          city: 'Denver',
                          state: 'Colorado',
                          zip: '80202',
                          email: 'JBob1234@hotmail.com',
                          password: 'heftybags',
                          password_confirmation: 'heftybags',
                          role: 1)


      visit '/login'
      fill_in :email, with: jake.email
      fill_in :password, with: jake.password


      expect(page).to have_link('Home')
      expect(page).to have_link('All Items')
      expect(page).to have_link('All Merchants')
      expect(page).to have_link('Cart')
      expect(page).to have_link('Register')
      expect(page).to have_content('0')
      click_on "Login"
      expect(page).to have_link('My Profile')
      expect(page).to have_link('Merchant Dashboard')
      expect(page).to have_link('Log Out')
      expect(page).not_to have_link('Log In')
      expect(page).not_to have_link('Register')
      expect(page).to have_content("Logged in as #{jake.name}")
    end
  end
  describe "When I try to access any path that begins with the following, then I see a 404 error:" do
    it "'/admin'" do
      jake = User.create!(name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'JBob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 1)

      visit "/admin"

      expect(page).to have_content("The page you were looking for doesn't exist (404)")
    end
  end
end
