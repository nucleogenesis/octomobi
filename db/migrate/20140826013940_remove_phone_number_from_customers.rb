class RemovePhoneNumberFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :phone_number, :string
  end
end
