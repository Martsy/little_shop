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
      it 'returns boolean based on item order' do
        megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
        brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)

        hippo = brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
        giant = megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
        order1 =Order.create!(name: 'Jack', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80202)
        OrderItem.create!(order: order1, item: hippo, quantity: 1, price: 50)

        expect(giant.ordered?).to eq(false)
        expect(hippo.ordered?).to eq(true)
      end
    end
  end
end
