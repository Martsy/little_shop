# frozen_string_literal: true
require "rails_helper"

RSpec.describe 'Review' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
    @giant = @megan.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)
    @review1 = @ogre.reviews.create!(title: 'I love it!', rating: 5, content: 'A must buy')
    @review2 = @giant.reviews.create!(title: 'Not my favorite', rating: 1, content: 'Going into the closet.')
    @review3 = @hippo.reviews.create!(title: 'Makes a good gift', rating: 3, content: 'good quality just not for me.')
  end

  describe "when I visit a item's show page" do
    it 'shows me a button to delete each review' do
      visit item_path(@ogre)

      expect(current_path).to eq("/items/#{@ogre.id}")

      expect(page).to have_button('Delete Review')
    end
  end

  describe 'when I delete a review' do
    it "returns me to the item's show page" do
      visit "/items/#{@ogre.id}"

      within "#review-#{@review1.id}" do

        click_button('Delete Review')
      end

      expect(current_path).to eq("/items/#{@ogre.id}")

      expect(page).to_not have_content(@review1.title)
      expect(page).to_not have_content("Rating: #{@review1.rating}")
      expect(page).to_not have_content(@review1.content)

      expect(Review.all).to_not include(@review1)
      expect(Review.all).to include(@review2)
      expect(Review.all).to include(@review3)
    end
  end
end
