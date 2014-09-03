class RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters

	def create
		build_resource(sign_up_params)

		if resource.save
			if resource.active_for_authentication?
				set_flash_message :notice, :signed_up if is_navigational_format?
				sign_up(resource_name, resource)
				return render :json => {:success => true}
			else
				set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
				expire_session_data_after_sign_in!
				return render :json => {:success => true}
			end
		else
			clean_up_passwords resource
			return render :json => {:success => false, :errors => resource.errors}
		end
	end


	def sign_up(resource_name, resource)
		sign_in(resource_name, resource)
	end

	protected

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) do |u|
			u.permit(:first_name, :last_name,
					 :email, :password, :password_confirmation, :customer_type)
		end
		devise_parameter_sanitizer.for(:account_update) do |u|
			u.permit(:first_name, :last_name,
					 :email, :password, :password_confirmation, :current_password)
		end
	end
end
