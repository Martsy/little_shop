class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def subtotal
    price * quantity.to_i
  end
end
