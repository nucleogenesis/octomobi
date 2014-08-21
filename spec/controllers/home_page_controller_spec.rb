require 'rails_helper'

RSpec.describe HomePageController, :type => :controller do

	describe "GET 'index'" do
		## Pretty Vanilla Stuff for Integration Testing

		it "returns http success" do
			get 'index'
			expect(response).to be_success
		end
	end

end
