require 'spec_helper'
require 'rails_helper'

RSpec.describe ContactFeature, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@contact_feature = ContactFeature.new(phone_contact: "867-5309", 
												  site_id: @site.id)
		end
		it "Should require a site_id for an existing site" do
			@contact_feature.site_id = nil
			expect(@contact_feature).not_to be_valid
		end
			
		it "Should require at least one item
			(not including site_id) not to be null" do
			expect(@contact_feature).to be_valid
			expect(ContactFeature.new(site_id: @site.id)).not_to be_valid
		end
	end

	context "Callbacks" do
		# Test Callbacks
	end
end
