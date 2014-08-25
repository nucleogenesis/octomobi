class MobileSitesController < ApplicationController
	def index
		# Show the Octomobi Mobile Site
	end

	def show
		@slug = params[:slug]
	end
end
