class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :customer_id
      t.boolean :is_active
      t.boolean :auto_payment
      t.string :subscription_type
      t.datetime :payment_due_date
      t.datetime :expiry_date

      t.timestamps
    end
  end
end
