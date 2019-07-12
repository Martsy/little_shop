require 'rails_helper'

RSpec.describe 'Delete Item' do
  describe 'As a Visitor' do
    describe 'When I visit an items show page' do
      before :each do
        @brian = Merchant.create!(name: 'Brians Bagels', address: '125 Main St', city: 'Denver', state: 'CO', zip: 80_218)
        @hippo = @brian.items.create!(name: 'Hippo', description: "I'm a Hippo!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 3)

        @order1 = Order.create!(name: 'Jack', address: '123 Smith Road', city: 'Denver', state: 'CO', zip: 80202)
        @order_items = OrderItem.create!(order: @order1, item: @hippo, quantity: 1, price: 50)
      end

      it 'If merchants item has orders you cannot delete merchant' do
        visit "/merchants/#{@brian.id}"
        expect(page).to_not have_button(value: 'Delete')
      end
    end
  end
end
