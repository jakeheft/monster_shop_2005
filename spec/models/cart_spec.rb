require 'rails_helper'

RSpec.describe Cart do
  describe 'Instance Methods' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 5 )
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 2 )
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 3 )
      @cart = Cart.new({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.contents' do
      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2
        })
    end

    it '.add_item()' do
      @cart.add_item(@hippo.id.to_s)

      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 2,
        @hippo.id.to_s => 1
        })
    end

    it ".subtract_item()" do
      @cart.subtract_item(@giant.id.to_s)
      expect(@cart.contents).to eq({
        @ogre.id.to_s => 1,
        @giant.id.to_s => 1
        })
    end

    it '.total_items' do
      expect(@cart.total_items).to eq(3)
    end

    it '.items' do
      expect(@cart.items).to eq({@ogre => 1, @giant => 2})
    end

    it '.total' do
      expect(@cart.total).to eq(120)
    end

    it '.subtotal()' do
      bear = @megan.items.create!(name: 'Bear', description: "I'm an Bear!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 500)
      discount_1 = @megan.discounts.create!(
        percent: 10,
        min_qty: 100
      )
      cart = Cart.new({bear.id.to_s => 100})

      expect(@cart.subtotal(@ogre)).to eq(20)
      expect(@cart.subtotal(@giant)).to eq(100)
      expect(cart.subtotal(bear)).to eq(1800)
    end

    it '#item_discount()' do
      discount_1 = @megan.discounts.create!(
        percent: 10,
        min_qty: 100
      )
      discount_2 = @megan.discounts.create!(
        percent: 20,
        min_qty: 105
      )
      discount_3 = @brian.discounts.create!(
        percent: 30,
        min_qty: 105
      )
      discount_4 = @brian.discounts.create!(
        percent: 20,
        min_qty: 200
      )
      bear = @megan.items.create!(name: 'Bear', description: "I'm an Bear!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 500)
      unicorn = @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 500)
      fairy = @brian.items.create!(name: 'fairy', description: "I'm a fairy!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 500)


      cart = Cart.new({
        @ogre.id.to_s => 99,
        @giant.id.to_s => 100,
        @hippo.id.to_s => 150,
        bear.id.to_s => 200,
        unicorn.id.to_s => 200,
        fairy.id.to_s => 100
        })

      expect(cart.item_discount(@ogre)).to eq(0)
      expect(cart.item_discount(@giant)).to eq(10)
      expect(cart.item_discount(@hippo)).to eq(30)
      expect(cart.item_discount(bear)).to eq(20)
      expect(cart.item_discount(unicorn)).to eq(30)
      expect(cart.item_discount(fairy)).to eq(0)
    end

    it '#discounted_price()' do
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
      cart = Cart.new({
        tire.id.to_s => 5,
        })
      order = Order.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80_218, user_id: user.id, status: 'Pending')

      expect(cart.discounted_price(tire, discount.percent)).to eq(75)
    end

    it '#quantity_of()' do
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
      cart = Cart.new({
        tire.id.to_s => 5,
        })
      expect { tire.quantity }.to raise_error(NoMethodError)
      expect(cart.quantity_of(tire)).to eq(5)
    end

    it '#price_of()' do
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80_203)
      user = User.create!(name: 'JakeBob',
        address: '124 Main St',
        city: 'Denver',
        state: 'Colorado',
        zip: '80202',
        email: 'Bob12@hotmail.com',
        password: 'heftybags',
        password_confirmation: 'heftybags',
        role: 0
      )
      tire = meg.items.create(name: 'Gatorskins', description: "They'll never pop!", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 1200)
      horn = meg.items.create(name: 'Horn', description: "It honks", price: 100, image: 'https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588', inventory: 1200)
      discount = meg.discounts.create!(
        percent: 25,
        min_qty: 5
      )
      cart = Cart.new({
        tire.id.to_s => 5,
        horn.id.to_s => 1
        })

      expect(cart.price_of(tire)).to eq(75)
      expect(cart.price_of(horn)).to eq(100)
    end
  end
end
