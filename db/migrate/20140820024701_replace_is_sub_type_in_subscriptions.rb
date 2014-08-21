class ReplaceIsSubTypeInSubscriptions < ActiveRecord::Migration
  def change
	  remove_column :subscriptions, :subscription_type

	  add_column :subscriptions, :subscription_type, :string, default: "basic"
  end
end
