class Subdomain
	def matches?(request)
		request.subdomain.present?
	end
end
