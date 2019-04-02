class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.references :order, foreign_key: true
      t.references :item,  foreign_key: true

      t.float   :order_price
      t.integer :quantity
      t.boolean :fulfilled, default: false

      t.timestamps
    end
  end
end
