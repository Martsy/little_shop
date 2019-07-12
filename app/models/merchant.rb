class Merchant < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :items, dependent: :destroy

  def ordered?
    items.joins(:order_items).count != 0
  end
end
