require 'rails_helper'

RSpec.describe Customer, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = build(:customer)
			expect(@customer).to be_valid
		end
		it "Should require a first_name" do
			@customer.first_name = nil
			expect(@customer).not_to be_valid
		end
		it "Should require a last_name" do
			@customer.last_name = nil
			expect(@customer).not_to be_valid
		end
		it "Should require an email" do
			@customer.email = nil
			expect(@customer).not_to be_valid
		end
		it "Should require a phone number" do
			@customer.phone_number = nil
			expect(@customer).not_to be_valid
		end
	end
end
