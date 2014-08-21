require 'spec_helper'
require 'rails_helper'

RSpec.describe RssFeedFeature, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@feed = build(:rss_feed_feature, site_id: @site.id)

			expect(@feed).to be_valid
		end
		it "Should have a site id for existing site" do
			@feed.site_id = nil
			expect(@feed).not_to be_valid

			@feed.site_id = 999999999
			expect(@feed).not_to be_valid
		end
		it "Should require a title" do
			@feed.title = nil
			expect(@feed).not_to be_valid
		end
		it "Should require a feed_url" do
			@feed.feed_url = nil
			expect(@feed).not_to be_valid
		end
		it "Should require entries_to_show" do
			@feed.entries_to_show = nil
			expect(@feed).not_to be_valid
		end
	end
end
