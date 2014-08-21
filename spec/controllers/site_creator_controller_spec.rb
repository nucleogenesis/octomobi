require 'spec_helper'
require 'rails_helper'

RSpec.describe SiteCreatorController, :type => :controller do
	before(:each) do
		context "Not Signed In" do
			it "Gets a user that is not signed in" do
				expect(customer_signed_in?).to be_false
			end
			it "Flashes an alert" do
				expect(flash[:alert]).to eq("Must Be Logged In")
			end
			it "Redirects to user sign-in" do
				expect(response).to redirect_to new_customer_session_path
			end
		end
		@customer = FactoryGirl.create(:customer)
		sign_in @customer
	end

	context "site_creator#new" do
		context "Signed In Customer" do
			it "Renders Successfully"
			# It will render a template-- the new.html.erb
			# that template will render every other template
			# within it.
			#
			# Test the page itself with Capybara
			get :new
			expect(response.status).to eq(200)
		end

	end
	
	context "site_creator#create" do
		
	end

	context "site_creator#edit" do
	end

	context "site_creator#update" do
	end

	context "site_creator#destroy" do
	end
end
