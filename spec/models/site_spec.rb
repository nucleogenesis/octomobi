require 'spec_helper'
require 'rails_helper'

RSpec.describe Site, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = build(:site, customer_id: @customer.id)
		end
		it "Should require a customer id for existing customer" do
			@site.preview_url = nil
			expect(@site).to be_valid

			@site.customer_id = nil
			expect(@site).not_to be_valid

			@site.customer_id = 999999999
			expect(@site).not_to be_valid
		end
		it "Should require a title"
		it "Should require a slug"
		it "Should have a properly formatted slug"
		it "Should have a site_type"
		it "Should have a template"
	end
end
