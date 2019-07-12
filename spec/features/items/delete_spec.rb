# frozen_string_literal: true

require 'rails_helper'

require 'rails_helper'

RSpec.describe 'Delete Item' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80218)
        @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5 )
        @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3 )

        @review1 = @ogre.reviews.create!(title: 'I love it!', rating: 2, content: 'A must buy')
        @review2 = @giant.reviews.create!(title: 'Not my favorite', rating: 1, content: 'Going into the closet.')
        @review3 = @hippo.reviews.create!(title: 'Makes a good gift', rating: 3, content: 'good quality just not for me.')
        @review4 = @giant.reviews.create!(title: 'I love it!', rating: 5, content: 'A must buy')
        @review5 = @hippo.reviews.create!(title: 'Not my favorite', rating: 1, content: 'Going into the closet.')
        @review6 = @ogre.reviews.create!(title: 'Makes a good gift', rating: 2, content: 'good quality just not for me.')

      end

      it 'I can click a link to delete that item' do
        visit "/items/#{@giant.id}"

        click_button 'Delete Item'

        expect(current_path).to eq('/items')

        expect(page).to have_css("#item-#{@ogre.id}")
        expect(page).to have_css("#item-#{@hippo.id}")
        expect(page).to_not have_css("#item-#{@giant.id}")
      end

      describe 'When I delete an item' do
        it 'reviews are deleted' do
          visit "/items/#{@ogre.id}"

          expect(page).to have_content(@review1.title)
          expect(page).to have_content(@review1.content)
          expect(page).to have_content(@review1.rating)
          expect(page).to have_content(@review6.title)
          expect(page).to have_content(@review6.content)
          expect(page).to have_content(@review6.rating)

          click_on 'Delete Item'

          expect(page).to_not have_content(@review1.title)
          expect(page).to_not have_content(@review1.content)
          expect(page).to_not have_content(@review1.rating)

          expect(page).to_not have_content(@review6.title)
          expect(page).to_not have_content(@review6.content)
          expect(page).to_not have_content(@review6.rating)
        end
      end
    end
  end
end
