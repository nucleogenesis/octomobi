class SiteCreatorPreviewController < ApplicationController
	before_action :authenticate_customer!

	def new
		@customer = current_customer
		@site = Site.new(site_type: "preview")
		@active_features = Feature.all.where(is_active: true)
		@feature_ids = []

		# Each Active Feature.new needs an instance variable
		# and @feature_ids needs to be pushed to get CSS ids
		# setup easily in JS
		@active_features.each do |feature|
			@feature_ids.push(feature.css_id)
			constant = feature.title.split(" ").push("Feature")
			constant.each_index do |c| 
				constant[c] = constant[c].capitalize
			end
			constant = constant.join("").constantize
				
			new_title = feature.title.downcase.split(" ").join("_") + "_feature"
			
			puts constant
			puts new_title
			# Formatted Like "@content_page_feature"
			instance_variable_set("@#{new_title}", constant.new)
			puts @content_page_feature
		end
	end

	def create
		@site = Site.create(site_creator_preview_params)
		@features = params[:features].to_hash

		if @site.save
			if save_features(@features, @site.id)
				return render :json => {success: true}
			end
		else
			return render :json => {success: false}
		end
	end

	def ajax_handler
		@params = {}
		@return = {}
		params.each_pair do |k, v|
			@params.store(k, v) if k != "form_id" && k != "action" && k != "commit" && k != "controller"
		end
		@return.store(params[:form_id], @params)
		render :json => @return
	end

	private

	def site_creator_preview_params
		params.require(:site).permit(:id, :title, :desktop_site_url, 
									:google_analytics_api_key, :logo_url,
									:site_type, :customer_id, :slug, 
									:template)
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
end
