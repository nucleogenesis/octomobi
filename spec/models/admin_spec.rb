require 'spec_helper'
require 'rails_helper'

describe Admin, :type => :model do
	context "Validations" do
		before(:each) do 
			# Create a Valid Admin to Test in Each Block
			@admin = build(:admin)
			expect(@admin).to be_valid
		end
		it "should require a first name" do
			@admin.first_name = nil
			expect(@admin).not_to be_valid
		end
		it "should require a last name" do
			@admin.last_name = nil
			expect(@admin).not_to be_valid
		end
		it "should require an email address" do
			@admin.email = nil
			expect(@admin).not_to be_valid
		end
	end

	context "Custom Methods" do
		# Test Custom Methods
	end

	context "Callbacks" do
		# Test Callbacks
	end
end
