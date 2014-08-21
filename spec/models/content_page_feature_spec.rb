require 'spec_helper'
require 'rails_helper'

RSpec.describe ContentPageFeature, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@content_page = build(:content_page_feature, site_id: @site.id)
			expect(@content_page).to be_valid
		end
		it "Should require a site_id for an existing site" do
			@content_page.site_id = nil
			expect(@content_page).not_to be_valid

			@content_page.site_id = 999999999999
			expect(@content_page).not_to be_valid
		end
		it "Should require a title" do
			@content_page.title = nil
			expect(@content_page).not_to be_valid
		end
		it "Should require a slug" do
			@content_page.slug = nil
			expect(@content_page).not_to be_valid
		end
		it "Should require content" do
			@content_page.content = nil
			expect(@content_page).not_to be_valid
		end
	end

	context "Callbacks" do
		# Test Callbacks
	end
end
