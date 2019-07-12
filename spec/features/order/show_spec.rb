# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'New Order' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @order = Order.create!(name: 'Jack', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80_202)
  end

  it 'I can see the details of my cart on the new order page' do
    visit "/items/#{@ogre.id}"
    click_button 'Add Item'

    visit "/items/#{@ogre.id}"
    click_button 'Add Item'

    visit "/items/#{@hippo.id}"
    click_button 'Add Item'

    visit cart_path
    click_button 'Checkout'

    expect(current_path).to eq('/orders/new')

    within '#shipping-info' do
      fill_in 'Name', with: 'Jack'
      fill_in'Address', with: '123 Smith Road'
      fill_in'City', with: 'Denver'
      fill_in'State', with: 'CO'
      fill_in'Zip', with: 80_202

      click_button 'Create Order'
    end


    within "#item-#{@ogre.id}" do
      expect(page).to have_content(@ogre.name)
      expect(page).to have_content("Sold by: #{@megan.name}")
      expect(page).to have_content("Price: #{number_to_currency(@ogre.price)}")
      expect(page).to have_content('Quantity: 2')
      expect(page).to have_content('Subtotal: $40.00')
    end

    within "#item-#{@hippo.id}" do
      expect(page).to have_content(@hippo.name)
      expect(page).to have_content("Sold by: #{@brian.name}")
      expect(page).to have_content("Price: #{number_to_currency(@hippo.price)}")
      expect(page).to have_content('Quantity: 1')
      expect(page).to have_content('Subtotal: $50.00')
    end

    expect(page).to have_content('Total: $90.00')

    within '#shipping-info' do
      expect(page).to have_content('Jack')
      expect(page).to have_content('123 Smith Road')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content(80202)
      expect(page).to have_content("Order Date: #{@order.created_at.to_formatted_s(:short)}")
    end
  end
end
