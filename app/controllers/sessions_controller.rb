class SessionsController < Devise::SessionsController
	after_filter :set_csrf_headers, :only => [:create, :destroy]

	def create
		resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
		sign_in_and_redirect(resource_name, resource)
	end

	def destroy
		super
	end

	private
	def set_csrf_headers
		if request.xhr?
			response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
			response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
		end
	end

	def sign_in_and_redirect(resource_or_scope, resource=nil)
		scope = Devise::Mapping.find_scope!(resource_or_scope)
		resource ||= resource_or_scope
		sign_in(scope, resource) unless warden.user(scope) == resource
		return render :json => {:success => true}
	end

	def failure
		return render :json => {:success => false, :errors => ["Login failed."]}
	end
end
