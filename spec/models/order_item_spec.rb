require 'rails_helper'

RSpec.describe OrderItem do
  describe 'Relationships' do
    it { should belong_to :order }
    it { should belong_to :item }
  end

  describe 'Order Item within order' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)

      @order1 = Order.create!(name: 'Jack', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80202)
      @order_items = OrderItem.create!(order: @order1, item: @hippo, quantity: 2, price: 50)

      @review1 = @ogre.reviews.create!(title: 'I love it!', rating: 2, content: 'A must buy')
      @review2 = @giant.reviews.create!(title: 'Not my favorite', rating: 1, content: 'Going into the closet.')
      @review3 = @hippo.reviews.create!(title: 'Makes a good gift', rating: 3, content: 'good quality just not for me.')
      @review4 = @giant.reviews.create!(title: 'I love it!', rating: 5, content: 'A must buy')
      @review5 = @hippo.reviews.create!(title: 'Not my favorite', rating: 1, content: 'Going into the closet.')
      @review6 = @ogre.reviews.create!(title: 'Makes a good gift', rating: 2, content: 'good quality just not for me.')
    end
    it '.subtotal' do
      expect(@order_items.subtotal).to eq(100)
    end
  end
end
