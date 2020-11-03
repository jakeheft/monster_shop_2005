require 'rails_helper'

describe "As a merchant employee" do
  describe "When I visit my merchant dashboard" do
    it "I see the name and full address of the merchant I work for" do
      merchant = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      merchant.users.create!(
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
      visit "/merchant"

      expect(page).to have_content(merchant.name)
      expect(page).to have_content(merchant.full_address)
    end

    it "I see any pending orders from my merchant, each has order info with quantity and price of my items" do
      print_shop = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
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
      merchant_user = bike_shop.users.create!(name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'Bob1234@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 1
      )
      chain = bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      rack = bike_shop.items.create(name: "Bike Rack", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      paper = print_shop.items.create(name: "Paper", description: "They'll never rip!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 1200)
      order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user_id: user.id, status: "Pending")
      order_item_1 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2, status: "Pending")
      order_item_2 =  order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2, status: "Pending")
      order_item_3 = order_1.item_orders.create!(item: rack, price: rack.price, quantity: 2, status: "Pending")
      order_2 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user_id: user.id, status: "Pending")
      order_item_4 = order_2.item_orders.create!(item: paper, price: paper.price, quantity: 2, status: "Pending")

      visit "/login"
      fill_in :email, with: "Bob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/merchant"
      
      expect(page).to have_link(order_1.id)
      expect(page).to_not have_link(order_2.id)
      expect(page).to have_content(order_1.created_at)
      expect(page).to have_content(order_1.merchant_item_qty)
      expect(page).to have_content(order_1.merchant_item_value)
    end
  end
end
