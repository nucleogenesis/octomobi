class SiteCreatorPreviewController < ApplicationController
	before_action :authenticate_customer!

	def new
		@customer = current_customer
		@site = Site.new(site_type: "preview")
		@active_features = Feature.all.where(is_active: true)
		@feature_ids = []
		@active_features.each do |f|
			@feature_ids.push(f.css_id)
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
