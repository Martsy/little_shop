# frozen_string_literal: true

class Cart
  attr_reader :contents

  def initialize(contents)
    @contents = contents || Hash.new(0)
  end

  def total_count
    contents.values.sum
  end

  def count_of(item_id)
    contents[item_id.to_s].to_i
  end

  def add_item(item_id)
    contents.default = 0
    contents[item_id.to_s] += 1
  end

  def item_and_quantity
    contents.map do |item_id, _quantity|
      item_id.to_i
    end
  end

  def subtotal(item_id)
    item = Item.find(item_id)
    item.price * count_of(item_id)
  end

  def total
    contents.keys.sum do |item_id|
      subtotal(item_id)
    end
  end
end
