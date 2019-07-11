# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new('1' => 2, '2' => 3) }

  describe '#total_count' do
    it 'calculates the total number of items it holds' do
      expect(subject.total_count).to eq(5)
    end
  end

  describe '#add_item' do
    it 'adds a item to its contents' do
      cart = Cart.new(
        '1' => 2, # two copies of item 1
        '2' => 3 # three copies of item 2
      )
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq('1' => 3, '2' => 4)
    end
  end
end
