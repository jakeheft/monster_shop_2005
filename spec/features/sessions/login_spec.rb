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
        role: 0
      )

      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"
      expect(current_path).to eq("/profile")
      expect(page).to have_content("You are now logged in")
    end

    it "as a merchant user, I am redirected to my merchant dashboard" do
      merchant_user = User.create!(
        name: 'Mark Merchant',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'buymystuff@hotmail.com',
        password: 'merchantsrock',
        password_confirmation: 'merchantsrock',
        role: 1
      )
      visit "/login"

      fill_in :email, with: "buymystuff@hotmail.com"
      fill_in :password, with: "merchantsrock"
      click_button "Login"

      expect(current_path).to eq("/merchant")
      expect(page).to have_content("You are now logged in")
    end

    it "as a merchant user, I am redirected to my merchant dashboard" do
      admin = User.create!(
        name: 'Allen Admin',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'icontroleverything@hotmail.com',
        password: 'adminadmin',
        password_confirmation: 'adminadmin',
        role: 2
      )
      visit "/login"

      fill_in :email, with: "icontroleverything@hotmail.com"
      fill_in :password, with: "adminadmin"
      click_button "Login"

      expect(current_path).to eq("/admin")
      expect(page).to have_content("You are now logged in")
    end
  end

  describe "When I log in with bad credentials" do
    it "With a bad password I am redirected to the login page and informed of invalid credentials" do
      user = User.create!(
        name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'JBob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 0
      )

      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybag"

      click_button "Login"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Username and/or password is incorrect")
    end

    it "With a bad email I am redirected to the login page and informed of invalid credentials" do
      user = User.create!(
        name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'JBob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 0
      )

      visit "/login"

      fill_in :email, with: "JBlob1234@hotmail.com"
      fill_in :password, with: "heftybags"

      click_button "Login"

      expect(current_path).to eq("/login")
      expect(page).to have_content("Username and/or password is incorrect")
    end
  end
end
