# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

@jake = User.create!(name: 'JakeBob',
                    address: '124 Main St',
                    city: 'Denver',
                    state: 'Colorado',
                    zip: '80202',
                    email: 'JBob1234@hotmail.com',
                    password: 'heftybags',
                    password_confirmation: 'heftybags',
                    role: 2)
#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
cat_shop = Merchant.create(name: "Cat's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
fat_shop = Merchant.create(name: "Fats's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
tat_shop = Merchant.create(name: "Tats's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
mat_shop = Merchant.create(name: "Mat's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
gat_shop = Merchant.create(name: "Gat's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
rat_shop = Merchant.create(name: "Rat's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
bat_shop = Merchant.create(name: "Bats's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
vat_shop = Merchant.create(name: "Vat's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#bike_shop items
tire = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_bone = cat_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
tire = fat_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
pen = tat_shop.items.create!(name: "Ball", description: "They'll write!", price: 10, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
ball = mat_shop.items.create!(name: "Round", description: "They'll never pop!", price: 9, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 5)
straw = gat_shop.items.create!(name: "Long", description: "They'll suck pop!", price: 8, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 2)
eraser = rat_shop.items.create!(name: "Rubber", description: "They'll never write!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 7)

stick = bat_shop.items.create!(name: "wood", description: "They'll never grow!", price: 6, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 3)
toothpick = rat_shop.items.create!(name: "plastic", description: "They'll never pop!", price: 5, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 4)
trash = vat_shop.items.create!(name: "banana", description: "They'll never pop!", price: 4, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 55)
wrapper = cat_shop.items.create!(name: "gum", description: "They'll never pop!", price: 3, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 6)
film = tat_shop.items.create!(name: "junk", description: "They'll never pop!", price: 2, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 7)

order = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: @jake.id)
order.item_orders.create!(item_id: tire.id, price: tire.price, quantity: 10)
order.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9)
order.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8)
order.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7)
order.item_orders.create!(item_id: eraser.id, price: eraser.price, quantity: 6)

order.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 5)
order.item_orders.create!(item_id: toothpick.id, price: pen.price, quantity: 4)
order.item_orders.create!(item_id: trash.id, price: ball.price, quantity: 3)
order.item_orders.create!(item_id: wrapper.id, price: straw.price, quantity: 2)
order.item_orders.create!(item_id: film.id, price: eraser.price, quantity: 1)
