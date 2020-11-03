# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Someone's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
meg_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
cat_shop = Merchant.create(name: "Brian's Cat Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
mouse_shop = Merchant.create(name: "Brian's Mouse Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
giraffe_shop = Merchant.create(name: "Brian's Giraffe Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
hippo_shop = Merchant.create(name: "Brian's Hippo Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
penguin_shop = Merchant.create(name: "Brian's Penguin Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

#user
jake = User.create!(name: 'JakeBob',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob1234@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
john = User.create!(name: 'john',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob234@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
greg = User.create!(name: 'greg',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob34@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
garrett = User.create!(name: 'garrett',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob123@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
molly = User.create!(name: 'molly',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob12@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
erica = User.create!(name: 'erica',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob1@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
tom = User.create!(name: 'tom',
  address: '124 Main St',
  city: 'Denver',
  state: 'Colorado',
  zip: '80202',
  email: 'JBob@hotmail.com',
  password: 'heftybags',
  password_confirmation: 'heftybags',
  role: 0
)
#bike_shop items
tire1 = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 912)
tire2 = meg_shop.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 912)
pen = meg_shop.items.create!(name: "Ball", description: "They'll write!", price: 10, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 93)
ball = meg_shop.items.create!(name: "Round", description: "They'll never pop!", price: 9, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 95)
straw = penguin_shop.items.create!(name: "Long", description: "They'll suck pop!", price: 8, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 92)
eraser = penguin_shop.items.create!(name: "Rubber", description: "They'll never write!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
stick = penguin_shop.items.create!(name: "wood", description: "They'll never grow!", price: 4, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 93)
toothpick = meg_shop.items.create!(name: "plastic", description: "They'll never pop!", price: 4, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 94)
trash = cat_shop.items.create!(name: "banana", description: "They'll never pop!", price: 5, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 955)
wrapper = giraffe_shop.items.create!(name: "gum", description: "They'll never pop!", price: 6, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 96)
film1 = mouse_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
film2 = mouse_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
film3 = hippo_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)
film4 = hippo_shop.items.create!(name: "junk", description: "They'll never pop!", price: 7, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 97)

#dog_shop items
pull_toy = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 932)
dog_bone = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 921)

order1 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: jake.id, status: "Pending")
order2 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: jake.id, status: "Pending")
# order3 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: greg.id, status: "Shipped")
# order4 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: greg.id, status: "Shipped")
# order5 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: john.id, status: "Shipped")
# order6 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: john.id, status: "Packaged")
# order7 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: garrett.id, status: "Packaged")
# order8 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: garrett.id, status: "Packaged")
# order9 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: erica.id, status: "Packaged")
# order10 = Order.create!(name: 'JakeBob', address: '124 Main St', city: 'Denver',state: 'Colorado', zip: '80202', user_id: erica.id, status: "Packaged")

order1.item_orders.create!(item_id: tire1.id, price: tire1.price, quantity: 10, status: "Pending", merchant_id: bike_shop.id)
order1.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9, status: "Pending", merchant_id: meg_shop.id)
order1.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8, status: "Pending", merchant_id: meg_shop.id)
order1.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7, status: "Pending", merchant_id: penguin_shop.id)
order2.item_orders.create!(item_id: eraser.id, price: eraser.price, quantity: 6, status: "Pending", merchant_id: penguin_shop.id)
order2.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 5, status: "Pending", merchant_id: penguin_shop.id)
# order2.item_orders.create!(item_id: toothpick.id, price: toothpick.price, quantity: 4, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: trash.id, price: trash.price, quantity: 3, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: wrapper.id, price: wrapper.price, quantity: 2, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: film2.id, price: film2.price, quantity: 1, status: "Packaged", merchant_id: .id)
#
# order4.item_orders.create!(item_id: tire2.id, price: tire2.price, quantity: 10, status: "Packaged", merchant_id: .id)
# order4.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9, status: "Packaged", merchant_id: .id)
# order5.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8, status: "Packaged", merchant_id: .id)
# order5.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7, status: "Packaged", merchant_id: .id)
# order6.item_orders.create!(item_id: eraser.id, price: eraser.price, quantity: 6, status: "Packaged", merchant_id: .id)
# order7.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 5, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: toothpick.id, price: toothpick.price, quantity: 4, status: "Packaged", merchant_id: .id)
# order9.item_orders.create!(item_id: trash.id, price: trash.price, quantity: 3, status: "Packaged", merchant_id: .id)
# order10.item_orders.create!(item_id: wrapper.id, price: wrapper.price, quantity: 2, status: "Packaged", merchant_id: .id)
# order1.item_orders.create!(item_id: film3.id, price: film3.price, quantity: 1, status: "Packaged", merchant_id: .id)
#
# order1.item_orders.create!(item_id: tire1.id, price: tire1.price, quantity: 10, status: "Packaged", merchant_id: .id)
# order4.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 9, status: "Packaged", merchant_id: .id)
# order4.item_orders.create!(item_id: ball.id, price: ball.price, quantity: 8, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: straw.id, price: straw.price, quantity: 7, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: eraser.id, price: eraser.price, quantity: 6, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 5, status: "Packaged", merchant_id: .id)
# order2.item_orders.create!(item_id: toothpick.id, price: toothpick.price, quantity: 4, status: "Packaged", merchant_id: .id)
# order2.item_orders.create!(item_id: trash.id, price: trash.price, quantity: 3, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: wrapper.id, price: wrapper.price, quantity: 2, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: film4.id, price: film4.price, quantity: 1, status: "Packaged", merchant_id: .id)
#
# order1.item_orders.create!(item_id: tire1.id, price: tire1.price, quantity: 10, status: "Packaged", merchant_id: .id)
# order4.item_orders.create!(item_id: film3.id, price: film3.price, quantity: 9, status: "Packaged", merchant_id: .id)
# order4.item_orders.create!(item_id: film2.id, price: film2.price, quantity: 8, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: film2.id, price: film2.price, quantity: 7, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: film4.id, price: film4.price, quantity: 6, status: "Packaged", merchant_id: .id)
# order8.item_orders.create!(item_id: pen.id, price: pen.price, quantity: 5, status: "Packaged", merchant_id: .id)
# order2.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 4, status: "Packaged", merchant_id: .id)
# order2.item_orders.create!(item_id: stick.id, price: stick.price, quantity: 3, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: film1.id, price: film1.price, quantity: 2, status: "Packaged", merchant_id: .id)
# order3.item_orders.create!(item_id: film4.id, price: film4.price, quantity: 1, status: "Packaged", merchant_id: .id)
