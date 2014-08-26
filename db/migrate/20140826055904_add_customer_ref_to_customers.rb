class AddCustomerRefToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :customer_ref, :string, :default => nil
  end
end
