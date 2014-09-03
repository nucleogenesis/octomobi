class SubscriptionsController < ApplicationController
	def new
		# This is where the url and redirect for sending
		# the user to FastSpring is created. User is sent
		# here from any link to a product within the site.
	end

	def create_pending
		token = SecureRandom.hex
		@subscription = Subscription.new(subscription_type: "pending", 
										 customer_id: current_customer.id,
										 api_key: token)
		if @subscription.save
			return render :json => {success: true, api_key: token,
									customer_id: current_customer.id}
		else
			return render :json => {success: false}
		end
	end

	def update
		# This is where the url and redirect for sending
		# the user to FastSpring for an account upgrade,
		# downgrade or deactivation is created.
	end

	def cancel
		# This is where the url and redirect for sending
		# the user to FastSpring to cancel their account
		# is created.
	end

	def activate
		# This is where FastSpring hits the callback after
		# an account is created, updated, or cancelled.
	end

	def deactivate
		# This is where FastSpring hits the callback for
		# when a user deactivates their account.
	end

end
