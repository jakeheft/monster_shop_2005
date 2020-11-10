require 'rails_helper'

describe "As a merchant employee" do
  describe "When I visit an order show page" do
    it "I see the recipient's name and address and the items in the order that belong to me." do
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
      chain = bike_shop.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      tire = bike_shop.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      rack = print_shop.items.create(name: 'Bike Rack', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Pending')
      order_item_1 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_item_2 =  order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_item_3 = order_1.item_orders.create!(item: rack, price: rack.price, quantity: 2, status: 'Pending', merchant_id: print_shop.id)

      visit "/login"
      fill_in :email, with: "Bob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/merchant/orders/#{order_1.id}"

      expect(page).to have_link(chain.name)
      expect(page).to have_link(tire.name)
      expect(page).to have_xpath("//img[contains(@src, '#{chain.image}')]")
      expect(page).to have_xpath("//img[contains(@src, '#{tire.image}')]")
      expect(page).to have_content(chain.price)
      expect(page).to have_content(tire.price)
      expect(page).to have_content(tire.order_quantity(order_1.id))
      expect(page).to have_content(chain.order_quantity(order_1.id))
      expect(page).to_not have_content(rack.name)
    end

    it "When I visit an order show page, if the desired quantity of the item
     is less or equal to current inventory and it is not already fulfilled,
     I see a button to fulfill that item." do
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
      chain = bike_shop.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      tire = bike_shop.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      rack = print_shop.items.create(name: 'Bike Rack', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Pending')
      order_item_1 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_item_2 =  order_1.item_orders.create!(item: tire, price: tire.price, quantity: 15, status: 'Pending', merchant_id: bike_shop.id)
      order_item_3 = order_1.item_orders.create!(item: rack, price: rack.price, quantity: 2, status: 'Pending', merchant_id: print_shop.id)

      visit "/login"
      fill_in :email, with: "Bob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/merchant"
      click_link "#{order_1.id}"
      expect(current_path).to eq("/merchant/orders/#{order_1.id}")

      expect(page).to have_link("Fulfill #{chain.name}")
      expect(page).to_not have_link("Fulfill #{tire.name}")
      expect(page).to have_content(chain.price)
      expect(page).to have_content(tire.price)
    end

    it "When I click on the link to fulfill the order, I am returned to the order
    show page and I see the item is now fulfilled. I also see a flash message
    indicating that I have fulfilled that item and the inventory is reduced by one" do

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
      chain = bike_shop.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      tire = bike_shop.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      rack = print_shop.items.create(name: 'Bike Rack', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Pending')
      order_item_1 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 2, status: 'Pending', merchant_id: bike_shop.id)
      order_item_2 =  order_1.item_orders.create!(item: tire, price: tire.price, quantity: 20, status: 'Pending', merchant_id: bike_shop.id)
      order_item_3 = order_1.item_orders.create!(item: rack, price: rack.price, quantity: 2, status: 'Pending', merchant_id: print_shop.id)

      visit "/login"
      fill_in :email, with: "Bob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/merchant/orders/#{order_1.id}"
      click_link "Fulfill #{chain.name}"
      expect(current_path).to eq("/merchant/orders/#{order_1.id}")

      expect(page).to_not have_link("Fulfill #{chain.name}")
      expect(page).to_not have_link("Fulfill #{tire.name}")

      expect(page).to have_content("Chain fulfilled")
      expect(page).to have_content("Chain has been fulfilled")
      expect(page).to have_content("Can't fullfill - Not enough items in inventory")
      chain.reload
      expect(chain.inventory).to eq(3)
    end

    it "If a discount has been applied I see the discounted item price" do
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
      discount = bike_shop.discounts.create(
        percent: 25,
        min_qty: 20
      )
      chain = bike_shop.items.create(name: 'Chain', description: "It'll never break!", price: 100, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 50)
      tire = bike_shop.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 120)
      order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Pending')
      order_item_1 = order_1.item_orders.create!(item: chain, price: chain.price, quantity: 19, status: 'Pending', merchant_id: bike_shop.id)
      order_item_2 =  order_1.item_orders.create!(item: tire, price: 75, quantity: 20, status: 'Pending', merchant_id: bike_shop.id)

      visit "/login"
      fill_in :email, with: "Bob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"

      visit "/merchant/orders/#{order_1.id}"

      within "#item-#{chain.id}" do
        expect(page).to have_content("Price: $100.00")
      end

      within "#item-#{tire.id}" do
        expect(page).to have_content("Price: $75.00")
      end
      expect(chain.price).to eq(chain.actual_price(order_1))
      expect(tire.price).to_not eq(tire.actual_price(order_1))
    end
  end
end
