require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart as a user' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      @items_in_cart = [@paper,@tire,@pencil]
    end

    it 'Theres a link to checkout' do
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
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/cart"

      expect(page).to have_link("Checkout")

      click_on "Checkout"

      expect(current_path).to eq("/orders/new")
    end
  end

  describe 'When I havent added items to my cart' do
    it 'There is not a link to checkout' do
      visit "/cart"

      expect(page).to_not have_link("Checkout")
    end
  end
end

describe "As a visitor" do
  describe "When I visit my cart with items in it" do
    it "It tells me I must register or log in to checkout with links for each" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      item = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

      visit "/items/#{item.id}"

      click_on "Add To Cart"
      expect(page).to have_content("Cart: 1")

      click_on "Cart"

      expect(page).to_not have_link("Checkout")
      expect(page).to have_content("You must register or log in to checkout")
      expect(page).to have_link("register")
      expect(page).to have_link("log in")
    end
  end
end

describe "As a user" do
  describe "When I visit my cart with items in it" do
    it "I click checkout and am redirected to a form to fill out order info" do
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

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      # allow_any_instance_of(ApplicationController).to receive(:cart).and_return({item.id => 1})
      visit "/items/#{item.id}"

      click_on "Add To Cart"

      visit cart_path

      click_on "Checkout"

      expect(current_path).to eq("/orders/new")
    end
    describe "I fill out the order info and click create order a pending order is created" do
      it "The order is associated with my user, I'm redirected to my orders, I see order creation flash, my order is listed and cart is empty" do
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
        item = dog_shop.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)

        visit "/login"

        fill_in :email, with: "JBob1234@hotmail.com"
        fill_in :password, with: "heftybags"
        click_button "Login"
        # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
        # allow_any_instance_of(ApplicationController).to receive(:cart).and_return({item.id => 1})
        visit "/items/#{item.id}"

        click_on "Add To Cart"

        visit '/orders/new'

        fill_in :name, with: user.name
        fill_in :address, with: user.address
        fill_in :city, with: user.city
        fill_in :state, with: user.state
        fill_in :zip, with: user.zip

        click_on 'Create Order'

        new_order = Order.last
        item_order = ItemOrder.last

        expect(current_path).to eq("/profile/orders")
        expect(new_order.status).to eq("Pending")
        expect(new_order.user).to eq(user)
        expect(page).to have_content("Your order has been created")
        expect(page).to have_content("Cart: 0")
      end

      it "When I create an order where a discount applies, that's reflected in the total" do
        meg = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        user = User.create!(name: 'JakeBob',
          address: '124 Main St',
          city: 'Denver',
          state: 'Colorado',
          zip: '80202',
          email: 'Bob1234@hotmail.com',
          password: 'heftybags',
          password_confirmation: 'heftybags',
          role: 0
        )
        tire = meg.items.create!(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 1200)
        discount = meg.discounts.create!(
          percent: 25,
          min_qty: 5
        )

        visit '/login'

        fill_in :email, with: 'Bob1234@hotmail.com'
        fill_in :password, with: 'heftybags'

        click_on 'Login'

        visit "/items/#{tire.id}"
        click_on 'Add To Cart'

        visit '/cart'

        within "#cart-item-#{tire.id}" do
          4.times { click_on '+' }
          expect(page).to have_content(5)
        end

        expect(page).to have_content("A bulk discount has been applied to #{tire.name}!")

        click_on 'Checkout'

        fill_in :name, with: user.name
        fill_in :address, with: user.address
        fill_in :city, with: user.city
        fill_in :state, with: user.state
        fill_in :zip, with: user.zip

        click_on 'Create Order'

        new_order = Order.last
        item_order = ItemOrder.last
      end
    end
  end
end
