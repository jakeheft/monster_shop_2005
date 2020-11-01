require 'rails_helper'

describe "As an admin" do
  describe "When I visit my admin dashboard" do
    before(:each) do
      @user = User.create!( name: 'JakeBob',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.comm',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 0
                          )
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      @tire = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @rack = @bike_shop.items.create(name: "Bike Rack", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @order_1 = Order.create!(name: 'JakeBob', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user_id: @user.id, status: "Pending")
      @order_item_1 = @order_1.item_orders.create!(item: @chain, price: @chain.price, quantity: 2, status: "Fulfilled")
      @order_item_2 =  @order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "Fulfilled")
      @order_item_3 = @order_1.item_orders.create!(item: @rack, price: @rack.price, quantity: 2, status: "Pending")
      @user_2 = User.create!( name: 'Sarah',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.com',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 0
                          )
      @order_2 = Order.create!(name: 'Sarah', address: '123 Stang St', city: 'whatwewant', state: 'PA', zip: 80218, user_id: @user_2.id, status: "Packaged")
      @order_item_4 = @order_2.item_orders.create!(item: @chain, price: @chain.price, quantity: 1, status: "Fulfilled")
      @order_item_5 =  @order_2.item_orders.create!(item: @tire, price: @tire.price, quantity: 1, status: "Fulfilled")
      @order_3 = Order.create!(name: 'Sarah', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user_id: @user_2.id, status: "Shipped")
      @order_item_6 = @order_3.item_orders.create!(item: @rack, price: @rack.price, quantity: 1, status: "Fulfilled")
      @order_4 = Order.create!(name: 'Sarah', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218, user_id: @user_2.id, status: "Packaged")
      @order_item_7 = @order_4.item_orders.create!(item: @chain, price: @chain.price, quantity: 1, status: "Fulfilled")
      @order_5 = Order.create!(name: 'Sarah', address: '123 Stang St', city: 'test', state: 'PA', zip: 80218, user_id: @user_2.id, status: "Cancelled")
      @order_item_9 = @order_5.item_orders.create!(item: @tire, price: @tire.price, quantity: 1, status: "Fulfilled")
      @user_3 = User.create!( name: 'Sarah',
                           address: '124 Main St',
                           city: 'Denver',
                           state: 'Colorado',
                           zip: '80202',
                           email: 'JBob1234@hotmail.commmm',
                           password: 'heftybags',
                           password_confirmation: 'heftybags',
                           role: 2
                          )
      visit '/login'
      fill_in :email, with: "JBob1234@hotmail.commmm"
      fill_in :password, with: "heftybags"
      click_button "Login"
      visit '/admin'
    end
    it "I see all orders in the system" do
      expect(page).to have_content(@order_1.id)
      expect(page).to have_content(@order_2.id)
      expect(page).to have_content(@order_3.id)
    end

    it "I see detailed information for all orders in the system and they are
      sorted by status" do
      visit '/admin'
      expect(page.all('h3')[0]).to have_content("Packaged")
      within "#packaged" do
        within "#order-#{@order_2.id}" do
          expect(page).to have_link(@user_2.name)
          expect(page).to have_content(@order_2.id)
          expect(page).to have_content(@order_2.created_at)
        end
        within "#order-#{@order_4.id}" do
          expect(page).to have_link(@user_2.name)
          expect(page).to have_content(@order_4.id)
          expect(page).to have_content(@order_4.created_at)
        end
      end
      expect(page.all('h3')[1]).to have_content("Pending")
      within "#pending" do
        within "#order-#{@order_1.id}" do
          expect(page).to have_link(@user.name)
          expect(page).to have_content(@order_1.id)
          expect(page).to have_content(@order_1.created_at)
        end
      end
      expect(page.all('h3')[2]).to have_content("Shipped")
      within "#shipped" do
        within "#order-#{@order_3.id}" do
          expect(page).to have_link(@user_2.name)
          expect(page).to have_content(@order_3.id)
          expect(page).to have_content(@order_3.created_at)
        end
      end
      expect(page.all('h3')[3]).to have_content("Cancelled")
      within "#cancelled" do
        within "#order-#{@order_5.id}" do
          expect(page).to have_link(@user_2.name)
          expect(page).to have_content(@order_5.id)
          expect(page).to have_content(@order_5.created_at)
        end
      end
    end
    it "when I click the user name link it goes to the admin view of user profile" do
      click_on "#{@user.name}"
      expect(current_path).to eq("/admin/users/#{@user.id}")
    end

    it "When I click the button to ship, located next to eah packaged order,
    the status is changed to 'shipped' and it can no longer be cancelled" do
      order = Order.find(@order_2.id)
      within "#packaged" do

        within "#order-#{order.id}" do
          expect(page).to have_button("Ship Order")
          click_button("Ship Order")
        end
        within "#order-#{@order_4.id}" do
          expect(page).to have_button("Ship Order")
          click_button("Ship Order")
        end
        expect(current_path).to eq("/admin")
        expect(page).to_not have_content(order.id)
        expect(page).to_not have_content(@order_4.id)
      end
      within "#shipped" do
        within "#order-#{order.id}" do
          expect(page).to have_content(order.id)
          expect(Order.find(order.id).status).to eq("Shipped")
        end
        within "#order-#{@order_4.id}" do
          expect(page).to have_content(@order_4.id)
        end
      end
      click_link("Log Out")
      click_link("Log In")
      fill_in :email, with: "JBob1234@hotmail.com"
      fill_in :password, with: "heftybags"
      click_button "Login"
      visit "/profile/orders/#{order.id}"
      expect(page).to_not have_button("Cancel Order")
    end
  end
end
