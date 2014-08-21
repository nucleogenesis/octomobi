require 'spec_helper'
require 'rails_helper'

RSpec.describe Payment, :type => :model do
	context "Validations" do
		before(:each) do 
			@customer = create(:customer)
			@subscription = create(:subscription)
			@payment = build(:payment, customer_id: @customer.id,
								subscription_id: @subscription.id)					 

			expect(@payment).to be_valid
		end
		it "Should require customer_id for existing customer" do
			@payment.customer_id = nil
			expect(@payment).not_to be_valid

			@payment.customer_id = 999999999
			expect(@payment).not_to be_valid
		end
		it "Should require subscription_id for existing subscription" do
			@payment.subscription_id = nil
			expect(@payment).not_to be_valid

			@payment.subscription_id = 999999999
			expect(@payment).not_to be_valid
		end
		it "Should require an amount" do
			@payment.amount = nil
			expect(@payment).not_to be_valid
		end
	end
end
