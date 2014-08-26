class AddDefaultToFastspringReferralInCustomers < ActiveRecord::Migration
  def change
	  remove_column :customers, :fastspring_referral, :string
	  add_column :customers, :fastspring_referral, :string, :default => nil
  end
end
