class AddOrdersToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :user, foreign_key: true
  end
end
