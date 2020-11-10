require 'rails_helper'

describe 'As a registered user' do
  describe "When I visit my Profile Orders page, '/profile/orders'" do
    describe "I see every order I've made, which includes the following information:" do
      it "the ID of the order, which is a link to the order show page, the date the order was
      made, the date the order was last updated, the current status of the order, the total quantity
      of items in the order, the grand total of all items for that order" do
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

        expect(page).to have_content(new_order.id)
        expect(page).to have_link(new_order.id)
        expect(page).to have_content(new_order.created_at)
        expect(page).to have_content(new_order.updated_at)
        expect(page).to have_content('Pending')
        expect(page).to have_content(new_order.items.count)
        expect(page).to have_content(new_order.grandtotal)
      end
    end
  end
end
