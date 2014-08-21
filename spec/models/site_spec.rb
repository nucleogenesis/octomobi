require 'spec_helper'
require 'rails_helper'

RSpec.describe Site, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = build(:site, customer_id: @customer.id)
		end
		it "Should require a customer id for existing customer" do
			expect(@site).to be_valid

			@site.customer_id = nil
			expect(@site).not_to be_valid

			@site.customer_id = 999999999
			expect(@site).not_to be_valid
		end

		it "Should require EITHER a basic or pro redirect" do
			@site.basic_redirect = nil
			@site.pro_redirect = nil

			expect(@site).not_to be_valid

			@site.pro_redirect = "localhost.com/site"
			expect(@site).to be_valid
		end

		it "Should require google api key" do
			@site.google_analytics_api_key = nil
			expect(@site).not_to be_valid
		end
	end
end
