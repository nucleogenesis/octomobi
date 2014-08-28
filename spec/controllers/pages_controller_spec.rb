require 'rails_helper'

RSpec.describe PagesController, :type => :controller do

  describe "GET 'retailer_pricing'" do
    it "returns http success" do
      get 'retailer_pricing'
      expect(response).to be_success
    end
  end

  describe "GET 'reseller_pricing'" do
    it "returns http success" do
      get 'reseller_pricing'
      expect(response).to be_success
    end
  end

end
