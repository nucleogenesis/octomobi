require 'spec_helper'
require 'rails_helper'

RSpec.describe Site, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = build(:site, customer_id: @customer.id)
		end
		it "Should require a site to have either a redirect or a preview url, but not both" do
			@preview = build(:site, basic_redirect: nil, pro_redirect: nil, preview_url: "pre")

			expect
		end
		it "Should require a customer id for existing customer" do
			@site.preview_url = nil
			expect(@site).to be_valid

			@site.customer_id = nil
			expect(@site).not_to be_valid

			@site.customer_id = 999999999
			expect(@site).not_to be_valid
		end

		it "Should require EITHER a basic or pro redirect or a preview_url" do
			@site.basic_redirect = nil
			@site.pro_redirect = nil

			expect(@site).not_to be_valid

			@site.pro_redirect = "localhost.com/site"
			expect(@site).to be_valid
		end
	end
end
