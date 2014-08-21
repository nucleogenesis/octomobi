require 'spec_helper'
require 'rails_helper'

RSpec.describe SocialLinksFeature, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@soc_links = build(:social_links_feature, site_id: @site.id)

			expect(@soc_links).to be_valid
		end

		it "Should require a site_id for a site that exists" do
			@soc_links.site_id = nil
			expect(@soc_links).not_to be_valid
		end

		it "Should have at least one attribute" do
			@soc_links = SocialLinksFeature.new(site_id: @site.id, facebook_url: "www.facebook.com/mypage")
			expect(@soc_links).to be_valid

			@soc_links.facebook_url = nil
			expect(@soc_links).not_to be_valid
		end
	end
end
