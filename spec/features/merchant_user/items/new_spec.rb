RSpec.describe 'Merchant Items Index Page' do
  describe 'When I visit the merchant items page' do
    before(:each) do
      @meg = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      @tire = @meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 12)
      @chain = @meg.items.create(name: 'Chain', description: "It'll never break!", price: 50, image: 'https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588', inventory: 5)
      @shifter = @meg.items.create(name: 'Shimano Shifters', description: "It'll always shift!", active?: false, price: 180, image: 'https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg', inventory: 2)
    end

    it 'When I click on the link to add a new item' do
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

      click_on 'Add New Item'

      expect(page).to have_content('Name')
      !find_field(:item_name)
      expect(page).to have_content('Description')
      !find_field(:item_description)
      expect(page).to have_content('Image')
      !find_field(:item_image)
      expect(page).to have_content('Price')
      !find_field(:item_price)
      expect(page).to have_content('Inventory')
      !find_field(:item_inventory)
      expect(page).to have_button('Create Item')
    end

    it 'creating a new item' do
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

      name = "Chamois Buttr"
      price = 18
      description = "No more chaffin'!"
      image_url = "https://images-na.ssl-images-amazon.com/images/I/51HMpDXItgL._SX569_.jpg"
      inventory = 25

      click_on "Add New Item"

      fill_in :item_name, with: name
      fill_in :item_price, with: price
      fill_in :item_description, with: description
      fill_in :item_image, with: image_url
      fill_in :item_inventory, with: inventory

      click_button "Create Item"

      expect(page).to have_content("New item has been created")
      expect(page).to have_css("#item-#{Item.last.id}")
    end
    it 'creating a new item(sad path)' do
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

      name = "Chamois Buttr"
      price = 18
      description = "No more chaffin'!"
      image_url = ""
      inventory = ""

      click_on "Add New Item"

      fill_in :item_name, with: name
      fill_in :item_price, with: price
      fill_in :item_description, with: description
      fill_in :item_image, with: image_url
      fill_in :item_inventory, with: inventory

      click_button "Create Item"

      expect(find_field(:item_name).value).to eq(name)
      expect(find_field(:item_description).value).to eq(description)
      expect(find_field(:item_image).value).to eq(image_url)
      expect(find_field(:item_price).value).to eq(price.to_s)
      expect(find_field(:item_inventory).value).to eq(inventory)

      expect(page).to have_content("Inventory can't be blank and Inventory is not a number")
    end
  end
end
