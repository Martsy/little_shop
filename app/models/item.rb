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

  def average_rating
    reviews.average(:rating).to_f
  end

  def best_reviews
    reviews.order(rating: :desc).limit(3)
  end

  def worst_reviews
    reviews.order(:rating).limit(3)
  end
end
