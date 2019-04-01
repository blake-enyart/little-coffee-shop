class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :email
      t.integer :role, default: 0
      t.boolean :enabled, default: true      

      t.timestamps
    end
  end
end
