require 'rails_helper'

RSpec.describe HomePageController, :type => :controller do

	describe "home_page#index" do
		it "Renders successfully" do
			get :index
			expect(response.status).to eq(200)
		end
	end
end
