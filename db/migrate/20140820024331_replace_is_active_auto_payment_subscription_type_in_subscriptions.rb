class ReplaceIsActiveAutoPaymentSubscriptionTypeInSubscriptions < ActiveRecord::Migration
  def change
	  remove_column :subscriptions, :is_active
	  remove_column :subscriptions, :auto_payment

	  add_column :subscriptions, :is_active, :boolean, default: false
	  add_column :subscriptions, :auto_payment, :boolean, default: false
  end
end
