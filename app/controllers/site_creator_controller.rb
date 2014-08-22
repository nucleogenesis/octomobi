class SiteCreatorController < ApplicationController
	def new
		# Just renders site_creator/new.html.erb
		# which then renders the html/javascript
		# that runs the site-creator app
	end

	def create
		print site_creator_params
		@site = Site.new(site_creator_params[:site])
		@features = site_creator_params[:features]


		if @site.save
			if save_features(@features)
				flash[:notice] = "Site #{@site.title} Created Succesfully"
				redirect_to customer_dashboard_path
			end
		else
			puts @site.errors.full_messages
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def site_creator_params
		params.require(:site).permit(:features, :title, :basic_redirect, 
									:pro_redirect, :desktop_site_url, 
									:google_analytics_api_key, :logo_location,
									:preview_url, :customer_id)
	end

	def save_features(features)
		raise("Features Invalid") unless features != nil && features.class == Hash

		save_feature = Proc.new do |key, value| 
			feature = key.new(value)
			unless feature.save then raise("Feature #{key} Invalid") end
		end

		features.each_pair do |k, v|
			feature_class = k.constantize
			if v.class == Array
				v.each do |val|
					save_feature.call(feature_class, val)
				end
			else
				save_feature.call(feature_class, v)
			end
		end

		return true
	end
end
