class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.float :price
      t.integer :quantity
      t.references :order, foreign_key: true
      t.references :item, foreign_key: true
    end
  end
end
