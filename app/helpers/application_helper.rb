module ApplicationHelper
	def resource_name
		:customer
	end

	def resource
		@resource ||= Customer.new
	end

	def devise_mapping
		@devise_mapping ||= Devise.mappings[:customer]
	end

	def find_feature(feature, id)
		# Feature will be a css class 'some_type_of_feature'
		feature = feature.split("_")
		feature.each_index do |i|
			feature[i] = feature[i].capitalize
		end
		feature = feature.join("").constantize

		return feature.find(id)
	end
end

