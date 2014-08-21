require 'spec_helper'
require 'rails_helper'

RSpec.describe GalleryImage, :type => :model do
	context "Validations" do
		before(:each) do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@gallery = create(:image_gallery_feature, site_id: @site.id)
			@image_1 = build(:gallery_image, image_gallery_feature_id: @gallery.id)
			@image_2 = build(:gallery_image, image_gallery_feature_id: 999999999)
		end

		it "Should require an image gallery id to existing gallery feature" do
			# Test a valid-- a non existant id-- and a nil value
			expect(@image_1).to be_valid
			expect(@image_2).not_to be_valid
		end

		it "Should require an image location" do
			@image_1.image_location = nil
			expect(@image_1).not_to be_valid
		end
	end
end
