class CustomersController < ApplicationController
	before_action :preset_creator_path

	layout "customers"

	def dashboard
	end

	def sites
	end

	def account
	end

	private
	# Default Site Creator Path set here depending on type of customer
	def preset_creator_path
		if current_customer && current_customer.customer_type &&
			current_customer.customer_type == "preview"

			@customer_type = "preview"
			@creator_path = new_site_creator_preview_path
		else
			@customer_type = current_customer.customer_type
			@creator_path = new_site_creator_path
		end
	end
end
