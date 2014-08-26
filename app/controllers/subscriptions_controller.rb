class SubscriptionsController < ApplicationController
	def new
		# This is where the url and redirect for sending
		# the user to FastSpring
	end

	def activate
		# This is where FastSpring hits the callback after
		# an account is created.
		#
		# create new subscription
		# create new payment (price gathered from product id)
	end

	def update
		# This is where FastSpring hits the callback
	end

end
