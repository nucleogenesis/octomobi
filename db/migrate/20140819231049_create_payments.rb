class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :customer_id
      t.integer :subscription_id
      t.integer :amount
      t.boolean :successful
      t.string :coupon_code

      t.timestamps
    end
  end
end
