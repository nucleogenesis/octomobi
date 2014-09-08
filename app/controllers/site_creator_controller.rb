class SiteCreatorController < ApplicationController
	before_action :authenticate_customer!
	before_action :authenticate_site_ownership, :only => [:edit, :update, :destroy]
	layout 'customers'

	def new
		@site = Site.new
		@active_features = Feature.all.where(is_active: true)
		@feature_ids = []
		@active_features.each do |f|
			@feature_ids.push(f.css_id)
		end

		respond_to do |format|
			format.html
			format.json {
				render :json => {
					customerType: current_customer.customer_type,
					featureIds: @feature_ids,
					activeFeatures: @active_features,
					action: params[:action]
				}
			}
		end
	end

	def create
		logger.debug(site_creator_params)
	end

	def edit
		@site = Site.find(params[:id])
		@features = @site.features

		active_features = Feature.all.where(is_active: true)
		@active_features = {};
		@feature_ids = []
		active_features.each do |f|
			@feature_ids.push(f.css_id)
			@active_features.store(f.css_id, f)
		end

		respond_to do |format|
			format.html
			format.json {
				render :json => {
					customerType: current_customer.customer_type,
					featureIds: @feature_ids,
					activeFeatures: @active_features,
					features: @features,
					site: @site,
					action: params[:action]
				}
			}
		end
	end

	def update
		logger.debug("---------------")
		logger.debug(params[:site])
		logger.debug("---------------")
		logger.debug(params[:features])
		logger.debug("---------------")
		logger.debug(params[:features][:introduction_feature_1])
		logger.debug("---------------")
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

	def parse
		@params = {}
		@return = {}
		params.each_pair do |k, v|
			@params.store(k, v) if k != "form_id" && k != "action" && k != "commit" && k != "controller"
		end
		@return.store(params[:form_id], @params)
		render :json => @return
	end

	def form
		form = params[:uniqClass].gsub(/_[0-9]+/, "")
		if form
			return render partial: "shared/site_creator/#{form}_form", 
					locals: {uniqClass: params[:uniqClass], id: params[:id]}
		else
			return render nothing: true
		end
	end

	def customer_type
		return render :json => {customerType: current_customer.customer_type}
	end

	def current_site_data
		return render :json => {site: Site.find(params[:site_id])}
	end

	private
	def site_creator_params
		params.require(:site).permit(:id, :title, :desktop_site_url, 
									:google_analytics_api_key, :logo_url,
									:site_type, :customer_id, :slug, 
									:template, :is_active)
		params.require(:features).permit(:introduction_feature, :content_page_feature)
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

				if !value.has_key?("0") && value[:site_id] == site_id 
					logger.debug("Got here with #{value}")
					if value.has_key?("id") && value[:id] != ""
						feature_class.find(value[:id]).update_attributes(value)
					else
						save_feature.call(feature_class, value)
					end
				elsif value.has_key?("0") 
					logger.debug("Way down here with #{value}")
					value.each_pair do |key, val|
						if val.has_key?("id") && val[:id] != "" && val[:site_id] == site_id
							feature_class.find(val[:id]).update_attributes(val)
						else
							logger.debug("Saving... #{key} | #{val}")
							save_feature.call(feature_class, val)
						end
					end
				else
					raise("Must Have Site Id")
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
		return true
	end	

	def authenticate_site_ownership
		# Ensure that the site trying to be accessed belongs to the
		# current user.
		if Site.find(params[:id]).customer_id != current_customer.id
			flash[:alert] = "Error. Please contact administrator if you are trying to
							access, edit, or update a site that you own."
			redirect_to customer_dashboard_path
		end
	end

	def authenticate_subscription
		# Ensure that the customer has a subscription that allows access to 
		# the site creator.
		if current_customer.customer_type == "preview"
			flash[:alert] = "That page does not exist."
			redirect_to root_path
		end
		if current_customer.subscription.is_active == false
			flash[:alert] = "You must update your subscription before you can
							access, update, or create a site."
			redirect_to customer_dashboard_path
		end
	end

end
