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
				introduction_feature: FactoryGirl.attributes_for(:introduction_feature),
				content_page_feature: [FactoryGirl.attributes_for(:content_page_feature),
						FactoryGirl.attributes_for(:content_page_feature)],
				external_links_feature: FactoryGirl.attributes_for(:external_links_feature),
				social_links_feature: FactoryGirl.attributes_for(:social_links_feature)
			}
			@site = FactoryGirl.attributes_for(:site, customer_id: @customer.id)
		end

		context "All Information is Valid" do
			before(:each) do
				post :create, site: @site, features: @features
				@saved_site = Site.first
			end
			it "Creates a new site from @site" do
				expect{Site.find(@saved_site.id)}.not_to raise_error
			end
			it "Creates a new feature for each feature with @saved_site.id" do
				expect{IntroductionFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect{ContentPageFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect{ExternalLinksFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect{SocialLinksFeature.find_by_site_id(@saved_site.id)}.not_to raise_error
				expect(ContentPageFeature.count).to eq(2)
			end

			it "Flashes success" do
				expect(flash[:notice]).to eq("Site #{@saved_site.title} Created Successfully!")
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
				"introduction_feature" => FactoryGirl.create(:introduction_feature, site_id: @site.id),
				"content_page_features" => [FactoryGirl.create(:content_page_feature, site_id: @site.id),
						FactoryGirl.create(:content_page_feature, site_id: @site.id)],
				"external_links_features" => FactoryGirl.create(:external_links_feature, site_id: @site.id),
				"social_links_feature" => FactoryGirl.create(:social_links_feature, site_id: @site.id)
			}
		end
		it "Assigns the site and features" do
			get :edit, id: @site.id
			expect(assigns(:site)).to eq(Site.find(@site.id))
			expect(assigns(:features)).to eq(@features)
		end
	end

	context "site_creator#update" do
		before(:each) do 
			@site = FactoryGirl.create(:site, customer_id: @customer.id)

			@int = FactoryGirl.create(:introduction_feature, site_id: @site.id)
			@cp1 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@cp2 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@cp3 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@cp4 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@ext = FactoryGirl.create(:external_links_feature, site_id: @site.id)
			@soc = FactoryGirl.create(:social_links_feature, site_id: @site.id)

			@up_features = {
				introduction_feature: FactoryGirl.attributes_for(:introduction_feature, id: @int.id, title: "New Title", site_id: @site.id),
				content_page_feature: [FactoryGirl.attributes_for(:content_page_feature, id: @cp1.id, title: "New Title", site_id: @site.id),
						   FactoryGirl.attributes_for(:content_page_feature, site_id: @site.id)],
				contact_feature: FactoryGirl.attributes_for(:contact_feature, site_id: @site.id),
				remove: {social_links_feature: 1, content_page_feature: [2, 4]}
			}
			@up_site = FactoryGirl.attributes_for(:site, title: "New Title")

			patch :update, id: @site.id, site: @up_site, features: @up_features
		end
		it "Updates the site and its features" do
			expect(Site.find(@site.id).title).to eq("New Title")
			expect(IntroductionFeature.find(1).title).to eq("New Title")
			expect(ContentPageFeature.find(1).title).to eq("New Title")
			expect(ContentPageFeature.count).to eq(3)
			expect(ContactFeature.count).to eq(1)
		end

		it "Redirects to dashboard" do
			expect(response).to redirect_to customer_dashboard_path
		end

		it "Redirects to the edit path if it fails" do
			@up_site[:title] = nil
			patch :update, id: @site.id, site: @up_site
			expect(response).to redirect_to edit_site_creator_path(@site.id)
		end
	end

	context "site_creator#destroy" do
		# This Destroys a site and all of its features
		before(:each) do 
			@site = FactoryGirl.create(:site, customer_id: @customer.id)
			@id = @site.id

			@int = FactoryGirl.create(:introduction_feature, site_id: @site.id)
			@cp1 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@cp2 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@cp3 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@cp4 = FactoryGirl.create(:content_page_feature, site_id: @site.id)
			@ext = FactoryGirl.create(:external_links_feature, site_id: @site.id)
		end
		it "Destroys the object by site id" do
			delete :destroy, id: @id
			expect(Site.find_by_id(@id)).to be_nil
			expect(IntroductionFeature.find_by_site_id(@id)).to be_nil
			expect(ContentPageFeature.find_by_site_id(@id)).to be_nil
			expect(ExternalLinksFeature.find_by_site_id(@id)).to be_nil
		end
	end
end
