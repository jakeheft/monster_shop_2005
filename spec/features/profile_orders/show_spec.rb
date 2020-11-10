require 'rails_helper'

RSpec.describe('Order Creation') do
  describe 'When I check out from my cart' do
    before(:each) do
      @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @user = User.create(
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
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @paper = @mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 3)
      @pencil = @mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)

      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'

      visit "/items/#{@paper.id}"
      click_on 'Add To Cart'
      visit "/items/#{@paper.id}"
      click_on 'Add To Cart'
      visit "/items/#{@tire.id}"
      click_on 'Add To Cart'
      visit "/items/#{@pencil.id}"
      click_on 'Add To Cart'

      visit '/cart'
      click_on 'Checkout'
    end

    it 'I can create a new order' do
      name = 'Bert'
      address = '123 Sesame St.'
      city = 'NYC'
      state = 'New York'
      zip = 10_001

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button 'Create Order'

      new_order = Order.last

      visit "/profile/orders/#{new_order.id}"

      within '.shipping-address' do
        expect(page).to have_content(name)
        expect(page).to have_content(address)
        expect(page).to have_content(city)
        expect(page).to have_content(state)
        expect(page).to have_content(zip)
      end

      within "#item-#{@paper.id}" do
        expect(page).to have_link(@paper.name)
        expect(page).to have_link(@paper.merchant.name.to_s)
        expect(page).to have_content("$#{@paper.price}")
        expect(page).to have_content('2')
        expect(page).to have_content('$40')
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_link(@tire.merchant.name.to_s)
        expect(page).to have_content("$#{@tire.price}")
        expect(page).to have_content('1')
        expect(page).to have_content('$100')
      end

      within "#item-#{@pencil.id}" do
        expect(page).to have_link(@pencil.name)
        expect(page).to have_link(@pencil.merchant.name.to_s)
        expect(page).to have_content("$#{@pencil.price}")
        expect(page).to have_content('1')
        expect(page).to have_content('$2')
      end

      within '#grandtotal' do
        expect(page).to have_content('Total: $142')
      end

      within '#datecreated' do
        expect(page).to have_content(new_order.created_at)
      end
    end

    it 'i cant create order if info not filled out' do
      name = ''
      address = '123 Sesame St.'
      city = 'NYC'
      state = 'New York'
      zip = 10_001

      fill_in :name, with: name
      fill_in :address, with: address
      fill_in :city, with: city
      fill_in :state, with: state
      fill_in :zip, with: zip

      click_button 'Create Order'

      expect(page).to have_content('Please complete address form to create an order.')
      expect(page).to have_button('Create Order')
    end
  end
  it "the ID of the order, the date the order was made, the date the order was last updated, the current status
  of the order, each item I ordered, including name, description, thumbnail, quantity, price and subtotal, the
  total quantity of items in the whole order, the grand total of all items for that order" do
    jake = User.create!(name: 'JakeBob',
                        address: '124 Main St',
                        city: 'Denver',
                        state: 'Colorado',
                        zip: '80202',
                        email: 'JBob1234@hotmail.com',
                        password: 'heftybags',
                        password_confirmation: 'heftybags',
                        role: 0)

    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
    tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
    paper = mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 3)
    pencil = mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)

    visit '/login'

    fill_in :email, with: 'JBob1234@hotmail.com'
    fill_in :password, with: 'heftybags'
    click_button 'Login'

    visit "/items/#{paper.id}"
    click_on 'Add To Cart'
    visit "/items/#{tire.id}"
    click_on 'Add To Cart'
    visit "/items/#{pencil.id}"
    click_on 'Add To Cart'
    visit '/cart'

    click_on 'Checkout'

    name = 'Bert'
    address = '123 Sesame St.'
    city = 'NYC'
    state = 'New York'
    zip = 10_001

    fill_in :name, with: name
    fill_in :address, with: address
    fill_in :city, with: city
    fill_in :state, with: state
    fill_in :zip, with: zip

    click_button 'Create Order'

    visit '/profile/orders'

    new_order = Order.last
    click_on new_order.id.to_s

    expect(page).to have_content(new_order.id)
    expect(page).to have_content(new_order.created_at)
    expect(page).to have_content(new_order.updated_at)
    expect(page).to have_content('Pending')
    expect(page).to have_content(new_order.items.count)
    expect(page).to have_content(new_order.grandtotal)

    within "#item-#{tire.id}" do
      expect(page).to have_content(tire.name)
      expect(page).to have_content(tire.description)
      expect(page).to have_css("img[src*='#{tire.image}']")
      expect(page).to have_content(1)
      expect(page).to have_content(100)
    end
  end
  describe 'I see a button or link to cancel the order' do
    describe 'When I click the cancel button for an order, the following happens:' do
      it "Each row in the 'order items' table is given a status of 'unfulfilled',
      The order itself is given a status of 'cancelled', Any item quantities in the order that were
      previously fulfilled have their quantities returned to their respective merchant's inventory for that item.,
      I am returned to my profile page, I see a flash message telling me the order is now cancelled,
      And I see that this order now has an updated status of 'cancelled'" do
        jake = User.create!(name: 'JakeBob',
                            address: '124 Main St',
                            city: 'Denver',
                            state: 'Colorado',
                            zip: '80202',
                            email: 'JBob1234@hotmail.com',
                            password: 'heftybags',
                            password_confirmation: 'heftybags',
                            role: 0)

        mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
        tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
        paper = mike.items.create(name: 'Lined Paper', description: 'Great for writing on!', price: 20, image: 'https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png', inventory: 3)
        pencil = mike.items.create(name: 'Yellow Pencil', description: 'You can write on paper with it!', price: 2, image: 'https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg', inventory: 100)

        visit '/login'

        fill_in :email, with: 'JBob1234@hotmail.com'
        fill_in :password, with: 'heftybags'
        click_button 'Login'

        visit "/items/#{paper.id}"
        click_on 'Add To Cart'
        visit "/items/#{tire.id}"
        click_on 'Add To Cart'
        visit "/items/#{pencil.id}"
        click_on 'Add To Cart'

        visit '/cart'

        click_on 'Checkout'

        name = 'Bert'
        address = '123 Sesame St.'
        city = 'NYC'
        state = 'New York'
        zip = 10_001

        fill_in :name, with: name
        fill_in :address, with: address
        fill_in :city, with: city
        fill_in :state, with: state
        fill_in :zip, with: zip

        click_button 'Create Order'

        visit '/profile/orders'

        new_order = Order.last

        click_on new_order.id.to_s

        click_on 'Cancel Order'

        expect(current_path).to eq('/profile/orders')

        expect(new_order.item_orders.all? { |item_order| item_order.status == 'Unfulfilled' }).to eq(true)

        within "#item-#{new_order.id}" do
          expect(page).to have_content('Cancelled')
        end

        expect(page).to have_content("Your order is now cancelled")

        expect(Item.find(tire.id).inventory).to eq(13)
      end
    end
  end
end
