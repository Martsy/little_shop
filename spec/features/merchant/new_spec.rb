require 'rails_helper'

RSpec.describe 'New Merchant Creation' do
  describe 'As a Visitor' do
    it 'I can link to a new merchant page from merchant index' do
      visit '/merchants'

      click_link 'New Merchant'

      expect(current_path).to eq('/merchants/new')
    end

    it 'I can use the new merchant form to create a new merchant' do
      visit '/merchants/new'

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'Address', with: address
      fill_in 'City', with: city
      fill_in 'State', with: state
      fill_in 'Zip', with: zip

      click_button 'Create Merchant'

      expect(current_path).to eq('/merchants')
      expect(page).to have_link(name)
    end

    it "Flash message generated for incomplete merchant details" do
      visit '/merchants/new'

      name = 'Megans Marmalades'
      address = '123 Main St'
      city = "Denver"
      state = "CO"
      zip = 80218

      fill_in 'Name', with: name
      fill_in 'City', with: city
      click_button 'Create Merchant'

      expect(page).to have_content('Complete all merchant details to continue')
      expect(current_path).to eq("/merchants/new")
    end

  end
end
