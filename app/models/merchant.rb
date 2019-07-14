# frozen_string_literal: true

class Merchant < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :items, dependent: :destroy

  def ordered?
    items.joins(:order_items).count != 0
  end

  def merch_sold
    items.count
  end

  def average_price
    items.average(:price).to_f
  end

  def cities
    items.joins(:orders).distinct.pluck(:city)
  end
end
