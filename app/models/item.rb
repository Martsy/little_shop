# frozen_string_literal: true

class Item < ApplicationRecord
  belongs_to :merchant

  has_many :order_items
  has_many :orders, through: :order_items
  has_many :reviews, dependent: :destroy

  validates_presence_of :name, :description, :price, :image, :inventory

  def ordered?
    orders.count != 0
  end
end
