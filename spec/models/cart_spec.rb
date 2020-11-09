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
      expect(@cart.subtotal(@ogre)).to eq(20)
      expect(@cart.subtotal(@giant)).to eq(100)
    end

    it '#apply_discount?()' do
      discount = @megan.discounts.create!(
        percent: 10,
        min_qty: 100
      )
      discount_2 = @brian.discounts.create!(
        percent: 10,
        min_qty: 200
      )
      unicorn = @brian.items.create!(name: 'Unicorn', description: "I'm a Unicorn!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', inventory: 500)
      cart = Cart.new({
        @ogre.id.to_s => 99,
        @giant.id.to_s => 200,
        @hippo.id.to_s => 150,
        unicorn.id.to_s => 200
        })

      expect(cart.apply_discount?(@ogre.id.to_s)).to eq(false)
      cart.add_item(@ogre.id.to_s)
      expect(cart.apply_discount?(@ogre.id.to_s)).to eq(true)
      expect(cart.apply_discount?(@giant.id.to_s)).to eq(true)
      expect(cart.apply_discount?(@hippo.id.to_s)).to eq(false)
      expect(cart.apply_discount?(unicorn.id.to_s)).to eq(true)
    end

    it '#discount_selection()' do
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
        @ogre.id.to_s => 99, # no discount
        @giant.id.to_s => 100, #discount 1
        @hippo.id.to_s => 150, # discount 3
        bear.id.to_s => 200, # discount 2
        unicorn.id.to_s => 200, #discount 3
        fairy.id.to_s => 100 #no discount
        })

      expect(cart.discount_selection(@ogre.id.to_s, @ogre.merchant)).to eq(nil)
      expect(cart.discount_selection(@giant.id.to_s, @giant.merchant)).to eq(discount_1)
      expect(cart.discount_selection(@hippo.id.to_s, @hippo.merchant)).to eq(discount_3)
      expect(cart.discount_selection(bear.id.to_s, bear.merchant)).to eq(discount_2)
      expect(cart.discount_selection(unicorn.id.to_s, unicorn.merchant)).to eq(discount_3)
      expect(cart.discount_selection(fairy.id.to_s, fairy.merchant)).to eq(nil)
    end
  end
end
