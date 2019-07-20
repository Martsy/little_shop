# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Merchant Show Page' do
  describe 'As a visitor' do
    before :each do
      @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
      @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    end

    it 'I see merchant name and address' do
      visit "/merchants/#{@megan.id}"
      expect(page).to have_content(@megan.name)
      expect(page).to have_content(@megan.address)
      expect(page).to have_content("#{@megan.city} #{@megan.state} #{@megan.zip}")
    end

    it 'I see a link for items' do
      visit "/merchants/#{@megan.id}"
      expect(page).to have_button('Merchant Items')
    end

    it 'has merchant stats' do
      @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
      @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      @order1 = Order.create!(name: 'Jack Black', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80_202)
      @order_item1 = OrderItem.create!(item: @ogre, order: @order1, price: @ogre.price, quantity: 3)

      visit merchant_path(@megan)

      expect(page).to have_content("Merchant sells #{@megan.merch_sold} items.")
      expect(page).to have_content("Average price: #{@megan.average_price}")
      expect(page).to have_content("Cities sold to: #{@megan.cities}")
    end
  end
end
