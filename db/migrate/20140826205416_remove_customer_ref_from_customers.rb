class RemoveCustomerRefFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :customer_ref, :string
  end
end
