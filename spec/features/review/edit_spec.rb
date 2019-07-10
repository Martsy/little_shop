require 'rails_helper'

RSpec.describe 'edit review' do
  before :each do
    @megan = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80_218)
    @ogre = @megan.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 20, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 5)
    @review = Review.create!(title: 'Great', content: "Broke within an hour", rating: 5, item_id: @ogre.id)
  end

  describe 'As a visitor when visit an item show page' do
    it 'I see a link to edit the review' do

      visit "/items/#{@ogre.id}"

      within "#review-#{@review.id}" do
        click_button 'Edit Review'
      end

      expect(current_path).to eq("/items/#{@ogre.id}/#{@review.id}/edit")

      fill_in 'Title', with: "Not so great"
      fill_in 'Content', with: "Broke within an hour"
      fill_in 'Rating', with: "1"

      click_on 'Update Review'

      expect(current_path).to eq("/items/#{@ogre.id}")

      within "#review-#{@review.id}" do
        expect(page).to have_content('Title: Not so great')
        expect(page).to have_content('Content: Broke within an hour')
        expect(page).to have_content('Rating: 1')
      end
    end
  end

  it "Flash message generated for incomplete review" do

    visit "/items/#{@ogre.id}"

    within "#review-#{@review.id}" do
      click_button 'Edit Review'
    end

    expect(current_path).to eq("/items/#{@ogre.id}/#{@review.id}/edit")

    fill_in 'Title', with: 'Great'
    fill_in 'Rating', with: ''
    click_on 'Update Review'

    expect(page).to have_content('Incomplete Review')
    expect(current_path).to eq("/items/#{@ogre.id}/#{@review.id}/edit")
  end

end
