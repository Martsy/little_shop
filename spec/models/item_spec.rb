# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Item do
  describe 'Relationships' do
    it { should belong_to :merchant }
    it { should have_many :order_items }
    it { should have_many(:orders).through(:order_items) }
    it { should have_many :reviews }

    describe 'Validations' do
      it { should validate_presence_of :name }
      it { should validate_presence_of :description }
      it { should validate_presence_of :price }
      it { should validate_presence_of :image }
      it { should validate_presence_of :inventory }
    end

    describe '#ordered' do
      it 'returns boolean if item ordered' do
        megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
        brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)

        hippo = brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
        giant = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
        order1 = Order.create!(name: 'Jack', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80_202)
        OrderItem.create!(order: order1, item: hippo, quantity: 1, price: 50)

        expect(giant.ordered?).to eq(false)
        expect(hippo.ordered?).to eq(true)
      end
    end

    describe 'Item Stats' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)

        @review1 = @ogre.reviews.create!(title: 'I love it!', rating: 5, content: 'A must buy')
        @review2 = @ogre.reviews.create!(title: 'Okay', rating: 2, content: 'Not impressed.')
        @review3 = @ogre.reviews.create!(title: 'Adorable', rating: 5, content: 'Not just for kids')
        @review4 = @ogre.reviews.create!(title: 'Not my favorite', rating: 1, content: 'Going into the closet.')
        @review5 = @ogre.reviews.create!(title: 'Makes a good gift', rating: 3, content: 'good quality just not for me.')
        @review6 = @ogre.reviews.create!(title: 'Fun toy', rating: 3, content: 'So cute!')
        @review7 = @ogre.reviews.create!(title: 'Broken', rating: 2, content: 'In the trash')
        @review8 = @ogre.reviews.create!(title: 'No complaints', rating: 4, content: 'As expected]')
      end

      it 'Displays average of all ratings' do
        expect(@ogre.average_rating).to eq(3.125)
      end

      it 'three best ratings' do
        expected = [@review1, @review3, @review8]
        expect(@ogre.best_reviews).to eq(expected)
      end

      it 'three worst ratings' do
        expected = [@review4, @review2, @review7]
        expect(@ogre.worst_reviews).to eq(expected)
      end
    end
  end
end
