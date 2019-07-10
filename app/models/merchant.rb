class Merchant < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :items
end
