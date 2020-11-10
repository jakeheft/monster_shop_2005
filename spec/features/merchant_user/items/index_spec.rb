RSpec.describe 'Merchant Items Index Page' do
  describe 'When I visit the merchant items page' do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @shifter = @meg.items.create(name: 'Shimano Shifters', description: "It'll always shift!", active?: false, price: 180, image: 'https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg', inventory: 2)
    end

    it 'I see a link or button to deactivate the item next to each item that is active' do
      user = @meg.users.create(name: 'JakeBob',
                               address: '124 Main St',
                               city: 'Denver',
                               state: 'Colorado',
                               zip: '80202',
                               email: 'JBob1234@hotmail.com',
                               password: 'heftybags',
                               password_confirmation: 'heftybags',
                               role: 1)

      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'

      visit '/merchant/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content('Active')
        expect(page).to_not have_content(@tire.description)
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_button('Deactivate')
        click_on 'Deactivate'
      end

      within "#item-#{@tire.id}" do
        expect(page).to have_content('Inactive')
      end

      expect(page).to have_content('This item is no longer for sale')
    end

    it 'merchant can activate a deactivated item' do
      user = @meg.users.create(name: 'JakeBob',
                               address: '124 Main St',
                               city: 'Denver',
                               state: 'Colorado',
                               zip: '80202',
                               email: 'JBob1234@hotmail.com',
                               password: 'heftybags',
                               password_confirmation: 'heftybags',
                               role: 1)

      visit '/login'

      fill_in :email, with: 'JBob1234@hotmail.com'
      fill_in :password, with: 'heftybags'
      click_button 'Login'

      visit '/merchant/items'

      within "#item-#{@shifter.id}" do
        expect(page).to have_content(@shifter.name)
        expect(page).to have_content("Price: $#{@shifter.price}")
        expect(page).to have_css("img[src*='#{@shifter.image}']")
        expect(page).to have_content('Inactive')
        expect(page).to_not have_content(@shifter.description)
        expect(page).to have_content("Inventory: #{@shifter.inventory}")
        expect(page).to have_button('Activate')
        expect(page).not_to have_button('Deactivate')
        click_on 'Activate'
      end
      within "#item-#{@shifter.id}" do
        expect(page).to have_content('Active')
      end

      expect(page).to have_content('This item is now available for sale')
    end
  end
end
