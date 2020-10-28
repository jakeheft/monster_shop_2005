require "rails_helper"

### Come back to this to add cleared shopping cart
describe "As a logged in user, merchant, or admin" do
  describe "When I visit the logout path, I am redirected to the home page" do
    it "I see a flash message that I'm logged out" do
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
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      item = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      visit "/login"

      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/items/#{item.id}"

      click_on "Add To Cart"
      expect(page).to have_content("Cart: 1")

      click_link "Log Out"

      expect(page).to have_content("Cart: 0")
      expect(current_path).to eq("/")
      expect(page).to have_content("You have successfully logged out")
    end
  end
end
