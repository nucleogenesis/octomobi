class AddFastspringReferralToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :fastspring_referral, :string
  end
end
