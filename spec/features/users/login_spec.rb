require "rails_helper"

describe "As a visitor" do
  describe "When I visit the login path I am able to login with valid credentials" do
    it "as a regular user, I am redirected to my profile page" do
      user = User.create(
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
      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are now logged in")
    end

    it "as a merchant user, I am redirected to my merchant dashboard" do
      merchant = User.create(
        name: 'Mark Merchant',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'buymystuff@hotmail.com',
        password: 'merchantsrock',
        password_confirmation: 'merchantsrock',
        role: 2
      )
      visit "/login"

      fill_in :email, with: "buymystuff@hotmail.com"
      fill_in :password, with: "merchantsrock"
      click_button "Login"
      expect(current_path).to eq("/merchants/#{merchant.id}")
      expect(page).to have_content("You are now logged in")
    end
  end
end

# If I am a merchant user, I am redirected to my merchant dashboard page
# If I am an admin user, I am redirected to my admin dashboard page
# And I see a flash message that I am logged in
