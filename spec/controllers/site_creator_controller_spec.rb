require 'spec_helper'
require 'rails_helper'

RSpec.describe SiteCreatorController, :type => :controller do
	before(:each) do
		@customer = FactoryGirl.create(:customer)
		sign_in @customer
	end

	context "site_creator#new" do
		context "Signed In Customer" do
			it "Renders Successfully" do
			# It will render a template-- the new.html.erb
			# that template will render every other template
			# within it.
			#
			# Test the page itself with Capybara
				get :new
				expect(response.status).to eq(200)
			end
		end

	end
	
	context "site_creator#create" do
		before(:each) do 
			@features = {
				introduction_feature: FactoryGirl.build(:introduction_feature),
				content_pages: [FactoryGirl.build(:content_page_feature),
						FactoryGirl.build(:content_page_feature)],
				external_links: FactoryGirl.build(:external_links_feature),
				social_links: FactoryGirl.build(:social_links_feature)
			}
			@site = FactoryGirl.attributes_for(:site, customer_id: @customer.id,
											   features: @features)
		end

		context "All Information is Valid" do
			before(:each) do
				post :create, site: @site
				@saved_site = Site.first
			end
			it "Creates a new site from @site" do
				expect{Site.find(@saved_site.id)}.not_to raise_error
			end
			it "Creates a new feature for each feature with @saved_site.id" do
				expect{IntroductionFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect{ContentPagesFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect{ExternalLinksFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect{SocialLinksFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect(ContentPagesFeature.count).to eq(2)
			end

			it "Flashes success" do
				expect(flash[:notice]).to eq("Site #{@site.title} Created Successfully!")
			end
			it "Returns the user to their dashboard" do
				expect(response).to redirect_to customer_dashboard_path
			end
		end
	end

	context "site_creator#edit" do
		before(:each) do 
			@site = FactoryGirl.create(:site)
			@features = {
				introduction_feature: FactoryGirl.create(:introduction_feature, site_id: @site.id),
				content_page_feature: [FactoryGirl.create(:content_page_feature, site_id: @site.id),
						FactoryGirl.create(:content_page_feature, site_id: @site.id)],
				external_links_feature: FactoryGirl.create(:external_links_feature, site_id: @site.id),
				social_links_feature: FactoryGirl.create(:social_links_feature, site_id: @site.id)
			}
		end
		it "Assigns the site and features" do
			expect(assigns(:site)).to eq(Site.find(@site.id))
			expect(assigns(:features)).to eq(@features)
		end
	end

	context "site_creator#update" do
		it "Updates the site and its features"
	end

	context "site_creator#destroy" do
	end
end
