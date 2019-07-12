# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new('1' => 2, '2' => 3) }
  describe 'total_count' do
    it 'calculates the total number of items it holds' do
      expect(subject.total_count).to eq(5)
    end
  end

  describe 'add_item' do
    it 'adds a item to its contents' do
      Cart.new('1' => 2, '2' => 3)
      subject.add_item(1)
      subject.add_item(2)
      expect(subject.contents).to eq('1' => 3, '2' => 4)
    end
  end

  describe 'contents' do
    it 'returns an empty hash' do
      cart = Cart.new(nil)
      expect(cart.contents).to eq({})
    end
  end

  describe 'total count' do
    it 'count of items' do
      cart = Cart.new('1' => 2, '3' => 1)
      expect(cart.total_count).to eq(3)
    end
  end

  describe 'count_of' do
    it ' quantity of an item' do
      cart = Cart.new('2' => 4, '1' => 2)
      expect(cart.count_of(1)).to eq(2)
    end
  end

  describe 'subtotal' do
    it 'item total' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      cart = Cart.new(Hash.new(0))
      cart.add_item(ogre.id)
      cart.add_item(ogre.id)
      expect(cart.subtotal(ogre.id)).to eq(40)
    end
  end

  describe 'total' do
    it 'cart total' do
      megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      hippo = brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      ogre = megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      cart = Cart.new(Hash.new(0))
      cart.add_item(ogre.id)
      cart.subtotal(hippo.id)
      expect(cart.total).to eq(20)
    end
  end

  describe '#item_and_quantity' do
    it 'returns an array of the item ids' do
      cart = Cart.new('1' => 1, '2' => 3)
      expect(cart.item_and_quantity).to eq([1, 2])
    end
  end
end
