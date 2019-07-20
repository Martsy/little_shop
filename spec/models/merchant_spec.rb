require 'rails_helper'

RSpec.describe Merchant do
  describe 'Relationships' do
    it {should have_many :items}
  end

  it 'calculates merchant stats' do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @order1 = Order.create!(name: 'Jack Black', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80202)
    @order_item1 = OrderItem.create!(item: @ogre, order: @order1, price: @ogre.price, quantity: 3)
    @order2 = Order.create!(name: 'Fred Black', address: '123 Main Road', city: 'Atlanta', state: 'GA', zip: 30301)
    @order_item2 = OrderItem.create!(item: @ogre, order: @order2, price: @ogre.price, quantity: 3)

      expect(@megan.merch_sold).to eq(2)
      expect(@megan.average_price).to eq(35)
      expect(@megan.cities).to eq(['Atlanta', 'Denver'])
      expect(@megan.ordered?).to eq(true)
      expect(@brian.ordered?).to eq(false)
  end


end
