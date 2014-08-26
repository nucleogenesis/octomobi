class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :reference
      t.integer :price
      t.string :payment_period

      t.timestamps
    end
  end
end
