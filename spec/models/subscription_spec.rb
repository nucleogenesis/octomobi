require 'spec_helper'
require 'rails_helper'

RSpec.describe Subscription, :type => :model do
	context "Validations" do
		it "Should require a customer id for an existing customer" do
			@customer = create(:customer)
			@sub = build(:subscription)

			expect(@sub).to be_valid

			@sub.customer_id = nil
			expect(@sub).not_to be_valid

			@sub.customer_id = 999999999
			expect(@sub).not_to be_valid
		end
	end
end
