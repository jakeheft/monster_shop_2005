require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      @jake = User.create!(name: 'JakeBob',
                         address: '124 Main St',
                         city: 'Denver',
                         state: 'Colorado',
                         zip: '80202',
                         email: 'JBob1234@hotmail.com',
                         password: 'heftybags',
                         password_confirmation: 'heftybags',
                         role: 0
                        )
      @tire = @meg.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
    end

    it "I can see a list of all of the items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end
    end

    describe "As any kind of user on the system" do
      describe "I can visit the items catalog ('/items')" do
        it "I see all items in the system except disables items, item image is a link" do
          visit '/items'

          expect(page).to have_link(@tire.name)
          expect(page).to have_link(@pull_toy.name)
          expect(page).not_to have_link(@dog_bone.name)
        end

        describe "When I visit '/items'" do
          describe "I see an area with statistics" do
            it "I see top 5 most/least popular items and quanitity purchased" do
              tire = @meg.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
              pen = @meg.items.create!(name: "Ball", description: "They'll write!", price: 10, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
              ball = @meg.items.create!(name: "Round", description: "They'll never pop!", price: 9, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
              straw = @meg.items.create!(name: "Long", description: "They'll suck pop!", price: 8, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
              eraser = @meg.items.create!(name: "Rubber", description: "They'll never write!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 7)

              stick = @meg.items.create!(name: "wood", description: "They'll never grow!", price: 6, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
              toothpick = @meg.items.create!(name: "plastic", description: "They'll never pop!", price: 5, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 4)
              trash = @meg.items.create!(name: "banana", description: "They'll never pop!", price: 4, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 55)
              wrapper = @meg.items.create!(name: "gum", description: "They'll never pop!", price: 3, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 6)
              film = @meg.items.create!(name: "junk", description: "They'll never pop!", price: 2, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 7)

              order = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: @jake.id)
              order.item_orders.create!(item_id: tire.id, price: tire.price, quantity: 10, merchant_id: @meg.id)
              order.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9, merchant_id: @meg.id)
              order.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8, merchant_id: @meg.id)
              order.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7, merchant_id: @meg.id)
              order.item_orders.create!(item_id: eraser.id, price: eraser.price, quantity: 6, merchant_id: @meg.id)
              order.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 5, merchant_id: @meg.id)
              order.item_orders.create!(item_id: toothpick.id, price: pen.price, quantity: 4, merchant_id: @meg.id)
              order.item_orders.create!(item_id: trash.id, price: ball.price, quantity: 3, merchant_id: @meg.id)
              order.item_orders.create!(item_id: wrapper.id, price: straw.price, quantity: 2, merchant_id: @meg.id)
              order.item_orders.create!(item_id: film.id, price: eraser.price, quantity: 1, merchant_id: @meg.id)

              visit '/items'

              within("#popularity_table") do
              expect(page).to have_content("Most Popular Items:")

              expect(page).to have_content(tire.name)
              expect(page).to have_content(order.item_orders[0].quantity)
              expect(page).to have_content(pen.name)
              expect(page).to have_content(order.item_orders[1].quantity)
              expect(page).to have_content(ball.name)
              expect(page).to have_content(order.item_orders[2].quantity)
              expect(page).to have_content(straw.name)
              expect(page).to have_content(order.item_orders[3].quantity)
              expect(page).to have_content(eraser.name)
              expect(page).to have_content(order.item_orders[4].quantity)

              expect(page).to have_content("Least Popular Items:")

              expect(page).to have_content(stick.name)
              expect(page).to have_content(order.item_orders[5].quantity)
              expect(page).to have_content(toothpick.name)
              expect(page).to have_content(order.item_orders[6].quantity)
              expect(page).to have_content(trash.name)
              expect(page).to have_content(order.item_orders[7].quantity)
              expect(page).to have_content(wrapper.name)
              expect(page).to have_content(order.item_orders[8].quantity)
              expect(page).to have_content(film.name)
              expect(page).to have_content(order.item_orders[9].quantity)
            end
            end
          end
        end
      end
    end
  end
end
