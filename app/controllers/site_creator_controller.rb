class SiteCreatorController < ApplicationController
	before_action :authenticate_customer!
	before_action :authenticate_site_ownership, :only => [:edit, :update, :destroy]

	def new
		@customer = current_customer
		@site = Site.new

		if !@customer.subscription || !@customer.subscription.is_active
			@preview = true
		else
			@preview = false
		end
	end

	def create
		@site = Site.new(site_creator_params)
		@features = params[:features].to_hash

		if @site.save
			if save_features(@features, @site.id)
				flash[:notice] = "Site #{@site.title} Created Successfully!"
				redirect_to customer_dashboard_path
			end
		else
			puts @site.errors.full_messages
		end
	end

	def edit
		@site = Site.find(params[:id])
		@features = @site.features
	end

	def update
		if update_features(site_creator_params,
						params[:features],
						params[:id])
			redirect_to customer_dashboard_path
		else
			redirect_to edit_site_creator_path(params[:id])
		end
	end

	def destroy
		key_list = ["introduction_feature", "social_links_feature",
				  "contact_feature", "image_gallery_feature", 
				  "content_page_features", "external_links_features",
				  "rss_feed_features"]

		@site = Site.find(params[:id])	

		key_list.each do |feature|
			if feature[-1] == 'e' && @site.send(feature)
				@site.send(feature).delete
			elsif feature[-1] == 's' && @site.send(feature) 
				@site.send(feature).destroy_all
			end
		end

		@site.destroy

	end

	private
	def site_creator_params
		params.require(:site).permit(:id, :title, :basic_redirect, 
									:pro_redirect, :desktop_site_url, 
									:google_analytics_api_key, :logo_location,
									:preview_url, :customer_id)
	end

	def save_features(features, site_id)
		raise("Features Invalid") unless features != nil && features.class == Hash

		save_feature = Proc.new do |key, value| 
			feature = key.new(value)
			unless feature.save then raise("Feature #{key} Invalid") end
		end

		features.each_pair do |k, v|
			feature_class = k.to_s.split("_")
			feature_class.each_index do |i|
				feature_class[i] = feature_class[i].capitalize
			end
			feature_class = feature_class.join("").constantize

			if v.class == Array
				v.each do |val|
					val.store(:site_id, site_id)
					save_feature.call(feature_class, val)
				end
			else
				v.store(:site_id, site_id)
				save_feature.call(feature_class, v)
			end
		end

		return true
	end

	def update_features(site = nil, features = nil, site_id = nil)
		unless site_id then raise ("Cannot update without a site id.") end

		# Extract Removal Hash from Features
		if features
			@removals = features[:remove] if features[:remove]
			features.keep_if { |k, v| k.to_s != "remove" }
		else
			@removals = nil
		end

		# Update The Site
		Site.find(site_id).update_attributes(site) if site

		# Helpers
		save_feature = Proc.new do |key, value|
			feature = key.new(value)
			unless feature.save then raise("Feature #{key} Invalid |
								#{feature.errors.full_messages} |
									 #{feature.attributes}") end
		end

		# Update Each Feature
		
		# Create Array of the has_one relationships for comparison
		@singular = [IntroductionFeature, SocialLinksFeature, ContactFeature,
				  ImageGalleryFeature]
		if features
			features.each_pair do |key, value|
				# Setup the Feature Class Constant as feature_class
				feature_class = key.to_s.split("_")
				feature_class.each_index do |i|
					feature_class[i] = feature_class[i].capitalize
				end
				feature_class  = feature_class.join("").constantize

				if value.class != Array && value[:site_id] == site_id 
					if value.has_key?("id") 
						feature_class.find(value[:id]).update_attributes(value)
					else
						save_feature.call(feature_class, value)
					end
				else
					value.each do |value|
						if value.has_key?("id") 
							feature_class.find(value[:id]).update_attributes(value)
						else
							save_feature.call(feature_class, value)
						end
					end
				end
			end
		end

		if @removals
			@removals.each_pair do |key, value|
				feature_class = key.to_s.split("_")
				feature_class.each_index do |i|
					feature_class[i] = feature_class[i].capitalize
				end
				feature_class  = feature_class.join("").constantize

				# If value is not an array, delete it
				if value.class != Array
					feature_class.destroy(value)
				else
					value.each do |value|
						feature_class.destroy(value)
					end
				end
			end
		end
	end	

	def authenticate_site_ownership
		# Ensure that the site trying to be accessed belongs to the
		# current user.
		if Site.find(params[:id]).customer_id != current_customer.id
			flash[:alert] = "There is no site by that name."
			redirect_to customer_dashboard_path
		end
	end

end
