require "rails_helper"

### Come back to this to add cleared shopping cart
describe "As a logged in user, merchant, or admin" do
  describe "When I visit the logout path, I am redirected to the home page" do
    it "I see a flash message that I'm logged out" do
      admin = User.create(
        name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'JBob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 2
      )
      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      click_link "Log Out"

      expect(current_path).to eq("/")
      expect(page).to have_content("You have successfully logged out")
    end
  end
end
