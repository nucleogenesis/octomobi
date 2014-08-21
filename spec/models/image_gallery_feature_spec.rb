require 'spec_helper'
require 'rails_helper'

RSpec.describe ImageGalleryFeature, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@gallery = build(:image_gallery_feature, site_id: @site.id)
			expect(@gallery).to be_valid
		end
		it "Should require a site_id of existing site" do
			@gallery.site_id = nil
			expect(@gallery).not_to be_valid
		end
		it "Should require a title" do
			@gallery.title = nil
			expect(@gallery).not_to be_valid
		end
	end
end
