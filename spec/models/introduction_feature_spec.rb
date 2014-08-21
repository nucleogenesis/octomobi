require 'spec_helper'
require 'rails_helper'

RSpec.describe IntroductionFeature, :type => :model do
	context "Validations" do
		it "Should require a title" do
			@customer = create(:customer)
			@site = create(:site, customer_id: @customer.id)
			@intro = build(:introduction_feature, site_id: @site.id)
			
			expect(@intro).to be_valid

			@intro.title = nil
			expect(@intro).not_to be_valid
		end
	end
end
