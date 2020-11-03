require 'rails_helper'

describe "As an admin, when I visit the merchant index page" do
  it "I click on a merchant's name, I'm directed to the admin merchant show page" do
    user = User.create(
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
    bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
    item = bike_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 932)

    visit "/login"

    fill_in :email, with: "JBob1234@hotmail.com"
    fill_in :password, with: "heftybags"
    click_button "Login"

    visit "/merchants"

    click_on "#{bike_shop.name}"
    expect(current_path).to eq("/admin/merchants/#{bike_shop.id}")
    expect(page)
    expect(page).to have_link(bike_shop.name)
    expect(page).to have_link("All #{bike_shop.name} Items")
    expect(page).to have_link("Update Merchant")
    expect(page).to have_content("Number of Items: #{bike_shop.item_count}")
    expect(page).to have_content("Average Price of Items: $#{bike_shop.average_item_price}")
    expect(page).to have_content("Cities that order these items:")
  end
end
