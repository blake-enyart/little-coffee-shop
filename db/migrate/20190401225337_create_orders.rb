class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
