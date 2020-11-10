require 'rails_helper'

RSpec.describe 'Cart show' do
  describe 'When I have added items to my cart' do
    describe 'and visit my cart path' do
      before(:each) do
        @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)

        @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
        @paper = @mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 25)
        @pencil = @mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)
        visit "/items/#{@paper.id}"
        click_on 'Add To Cart'
        visit "/items/#{@tire.id}"
        click_on 'Add To Cart'
        visit "/items/#{@pencil.id}"
        click_on 'Add To Cart'
        @items_in_cart = [@paper, @tire, @pencil]
      end

      it 'I can empty my cart by clicking a link' do
        visit '/cart'
        expect(page).to have_link('Empty Cart')
        click_on 'Empty Cart'
        expect(current_path).to eq('/cart')
        expect(page).to_not have_css('.cart-items')
        expect(page).to have_content('Cart is currently empty')
      end

      it 'I see all items Ive added to my cart' do
        visit '/cart'

        @items_in_cart.each do |item|
          within "#cart-item-#{item.id}" do
            expect(page).to have_link(item.name)
            expect(page).to have_css("img[src*='#{item.image}']")
            expect(page).to have_link(item.merchant.name.to_s)
            expect(page).to have_content("$#{item.price}")
            expect(page).to have_content('1')
            expect(page).to have_content("$#{item.price}")
          end
        end
        expect(page).to have_content('Total: $122')

        visit "/items/#{@pencil.id}"
        click_on 'Add To Cart'

        visit '/cart'

        within "#cart-item-#{@pencil.id}" do
          expect(page).to have_content('2')
          expect(page).to have_content('$4')
        end

        expect(page).to have_content('Total: $124')
      end
    end
  end
  describe "When I haven't added anything to my cart" do
    describe 'and visit my cart show page' do
      it 'I see a message saying my cart is empty' do
        visit '/cart'
        expect(page).to_not have_css('.cart-items')
        expect(page).to have_content('Cart is currently empty')
      end

      it 'I do NOT see the link to empty my cart' do
        visit '/cart'
        expect(page).to_not have_link('Empty Cart')
      end
    end
  end
  describe "When I have items in my cart" do
    describe 'I see a button or link to increment the count of items I want to purchase' do
      it "I cannot increment the count beyond the item's inventory size" do
        mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)

        tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
        paper = mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 25)
        pencil = mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 2)
        visit "/items/#{paper.id}"
        click_on 'Add To Cart'
        visit "/items/#{tire.id}"
        click_on 'Add To Cart'
        visit "/items/#{pencil.id}"
        click_on 'Add To Cart'
        items_in_cart = [paper, tire, pencil]

        visit '/cart'

        within "#cart-item-#{pencil.id}" do
          expect(page).to have_button('+')
          click_on '+'
          expect(page).to have_content(2)
          click_on '+'
        end
        expect(page).to have_content("Not Enough Inventory for #{pencil.name}")
      end
    end
    describe 'I see a button or link to decrement the count of items I want to purchase' do
      it 'If I decrement the count to 0 the item is immediately removed from my cart' do
        mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)

        tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
        paper = mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 25)
        pencil = mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)
        visit "/items/#{paper.id}"
        click_on 'Add To Cart'
        visit "/items/#{tire.id}"
        click_on 'Add To Cart'
        visit "/items/#{pencil.id}"
        click_on 'Add To Cart'
        items_in_cart = [paper, tire, pencil]

        visit '/cart'

        within "#cart-item-#{pencil.id}" do
          expect(page).to have_button('+')
          click_on '+'
          click_on '-'
          expect(page).to have_content(1)

          click_on "-"
        end
        within ".cart-items" do
          expect(page).not_to have_content(pencil.name)
        end
      end
    end

    describe "When I increase the quantity of my items to the minimum quantity for a discount" do
      it "The discount is automatically applied to that item" do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
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
        tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 1200)
        discount = meg.discounts.create!(
          percent: 25,
          min_qty: 100
        )

        visit '/login'

        fill_in :email, with: 'Bob1234@hotmail.com'
        fill_in :password, with: 'heftybags'

        click_on 'Login'

        visit "/items/#{tire.id}"
        click_on 'Add To Cart'
        click_link 'Cart'

        within "#cart-item-#{tire.id}" do
          99.times { click_on '+' }
          expect(page).to have_content(100)
          expect(page).to have_content("$7,500.00")
        end
        expect(page).to have_content("A bulk discount has been applied to #{tire.name}!")
      end
    end

    describe "When I have a discount applied to items" do
      it "The discounted price is reflected in the cart total" do
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
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
        paper = mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 25)
        pencil = mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)
        tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 1200)
        discount = meg.discounts.create!(
          percent: 25,
          min_qty: 5
        )

        visit '/login'

        fill_in :email, with: 'Bob1234@hotmail.com'
        fill_in :password, with: 'heftybags'

        click_on 'Login'

        visit "/items/#{paper.id}"
        click_on 'Add To Cart'
        visit "/items/#{tire.id}"
        click_on 'Add To Cart'
        visit "/items/#{pencil.id}"
        click_on 'Add To Cart'

        visit '/cart'

        within "#cart-item-#{tire.id}" do
          9.times { click_on '+' }
          expect(page).to have_content(10)
        end
        expect(page).to have_content("A bulk discount has been applied to #{tire.name}!")
        expect(page).to have_content("Total: $772.00")
      end
    end
  end
end
