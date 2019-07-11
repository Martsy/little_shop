# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Remove Item from Cart' do
  describe 'As a Visitor' do
    describe 'When I visit the cart show page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
      end

      it 'I can click a link to empty cart' do
        visit "/items/#{@ogre.id}"
        click_button 'Add Item'

        visit "/items/#{@ogre.id}"
        click_button 'Add Item'

        visit "/items/#{@hippo.id}"
        click_button 'Add Item'

        visit cart_path

        within "#item-#{@ogre.id}" do
          click_button 'Remove'
        end

        expect(current_path).to eq('/cart')
        expect(page).to have_content(@hippo.name)
      end

      it 'I can increment items in the cart' do
        visit "/items/#{@ogre.id}"
        click_button 'Add Item'

        visit "/items/#{@ogre.id}"
        click_button 'Add Item'

        visit "/items/#{@hippo.id}"
        click_button 'Add Item'

        visit cart_path

        within "#item-#{@ogre.id}" do
          click_button '+'
          expect(page).to have_content('Quantity: 3')
          click_button '+'
          click_button '+'
          click_button '+'
        end
        expect(page).to have_content('Order quantity exceeds inventory')
        expect(current_path).to eq('/cart')
      end

      it 'I can decrement items in the cart' do
        visit "/items/#{@ogre.id}"
        click_button 'Add Item'

        visit "/items/#{@ogre.id}"
        click_button 'Add Item'

        visit "/items/#{@hippo.id}"
        click_button 'Add Item'

        visit cart_path

        within "#item-#{@ogre.id}" do
          click_button '-'
          expect(page).to have_content('Quantity: 1')
          click_button '-'
        end
        expect(page).to_not have_content("Name: #{@ogre.name}")
        expect(current_path).to eq('/cart')
      end
    end
  end
end
