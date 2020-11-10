RSpec.describe 'Merchant edits an item' do
  describe 'And I click the edit button or link next to any item Then I am taken to a form similar to the new item form' do
    before(:each) do
      @meg = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @shifter = @meg.items.create(name: 'Shimano Shifters', description: "It'll always shift!", active?: false, price: 180, image: 'https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg', inventory: 2)
    end

    it 'The form is pre-populated with all of this items information and I can edit it' do
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
        click_on 'Edit Item'
      end
      expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")

      expect(find_field(:name).value).to eq(@tire.name)
      expect(find_field(:description).value).to eq(@tire.description)
      expect(find_field(:image).value).to eq(@tire.image)
      expect(find_field(:price).value).to eq("#{@tire.price}")
      expect(find_field(:inventory).value).to eq(@tire.inventory.to_s)

      fill_in :name, with: "Chipotle"

      click_on "Update Item"

      @tire.reload
      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
      end
    end

    it 'Sad path testing' do
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
        click_on 'Edit Item'
      end
      expect(current_path).to eq("/merchant/items/#{@tire.id}/edit")

      expect(find_field(:name).value).to eq(@tire.name)
      expect(find_field(:description).value).to eq(@tire.description)
      expect(find_field(:image).value).to eq(@tire.image)
      expect(find_field(:price).value).to eq("#{@tire.price}")
      expect(find_field(:inventory).value).to eq(@tire.inventory.to_s)

      fill_in :name, with: ""

      click_on "Update Item"

      expect(page).to  have_content("Name can't be blank")
    end
  end
end
