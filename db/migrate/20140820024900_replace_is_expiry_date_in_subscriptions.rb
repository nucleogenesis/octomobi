class ReplaceIsExpiryDateInSubscriptions < ActiveRecord::Migration
  def change
	  remove_column :subscriptions, :expiry_date

	  add_column :subscriptions, :expiry_date, :datetime, null: true, default: :null
  end
end
