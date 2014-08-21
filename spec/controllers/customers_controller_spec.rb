require 'spec_helper'
require 'rails_helper'

RSpec.describe CustomersController, :type => :controller do
	context "customers#new" do
		before(:each) do
			get :new
		end
		it "Assigns a new Customer to @customer" do
			expect(assigns(:customer)).to be_a_new(Customer)
		end
		it "Successfully Renders" do
			expect(response.status).to eq(200)
		end
	end

	context "customers#create" do
		context "Receives a Valid Customer" do
			before(:each) do
				@valid_customer = FactoryGirl.build(:customer) 
				post :create, customer: @valid_customer, sub_type: "basic"
			end
			it "Saves the Customer" do
				expect(Customer.find_by_email(@valid_customer.email)).to eq(Customer.last)
			end
			it "Flashes Success" do
				expect(flash[:notice]).to eq("Account Created Successfully")
			end
			it "Redirects to checkout/review giving with subscription_type" do
				expect(response.headers).to include(:sub_type)
				expect(response.status).to eq(301)
			end
		end
		context "Receives an Invalid User" do
			before(:each) do
				@invalid_customer = FactoryGirl.build(:customer, first_name: nil)
				post :create, customer: @invalid_customer, sub_type: "basic"
			end
			it "Does not Save the Customer" do
				expect(Customer.find_by_email(@invalid_customer.email)).to be_nil
			end
			it "Flashes an Alert of Failure" do
				expect(flash[:alert]).not_to be_nil
			end
			it "Redirects to customers#new" do
				expect(response).to redirect_to(new_customer_registration_path)
			end
		end
	end

	context "customers#edit" do
		context "Valid customer id given" do
			before(:each) do get :edit, id: 1 end

			it "Assigns customer by id to @customer" do
				expect(assigns(:customer)).to eq(Customer.find(id))
			end
			it "Renders successfully" do
				expect(response.status).to eq(200)
			end
		end
		context "Non-existing customer id" do
			before(:each) do get :edit, id: 9999 end

			it "Redirects to customer_dashboard_path" do
				expect(response).to redirect_to customer_dashboard_path
			end
			it "Flashes an alert that id does not exist" do
				expect(flash[:alert]).to eq("Customer with id #{id} does not exist.")
			end
		end
	end

	context "customers#update" do
		before(:each) do
			@customer = create(:customer)
			@update = build(:customer, first_name: "Chris", last_name: "Machado")
			post :update, customer: @update
		end
		context "Updated customer info is valid" do
			it "Updates the customer" do
				expect(Customer.find(@customer.id).attributes).to eq(@update)
			end
				
			it "Flashes success" do
				expect(flash[:notice]).to eq("Your Information has been Updated")
			end
			it "Redirects to customer_dashboard_path" do
				expect(response).to redirect_to customer_dashboard_path
			end
		end

		context "Updated customer info is NOT valid" do
			before(:each) do
				@update = build(:customer, first_name: nil)
			end
			it "Does not update the customer" do
				expect(Customer.find(@customer.id).attributes).not_to eq(@update)
			end
			it "Flashes an alert" do
				expect(flash[:alert]).to eq("Invalid Information-- Unable to Update")
			end
			it "Redirects to customers#edit with id param" do
				expect(response).to redirect_to new_customer_registration_path(id: @customer.id)
			end
		end
	end

	## No Destroy Method, Customers Only Become Inactive
end
