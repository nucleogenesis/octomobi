require 'spec_helper'
require 'rails_helper'

RSpec.describe ExternalLinksFeature, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@external_link = build(:external_links_feature, site_id: @site.id)
		end
		it "Should require a title" do
			@external_link.title = nil
			expect(@external_link).not_to be_valid
		end
		it "Should require a link" do
			@external_link.link = nil
			expect(@external_link).not_to be_valid
		end
		it "Should require a site_id for an existing site" do
			@external_link.site_id = nil
			expect(@external_link).not_to be_valid

			@external_link.site_id = 999999999
			expect(@external_link).not_to be_valid
		end
	end

	context "Callbacks" do
		# Test Callbacks
	end
end
