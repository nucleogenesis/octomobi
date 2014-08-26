OctomobiRails::Application.routes.draw do
  get "sessions/create"
	##
	#	Routes for 'm.octomobi.com'
	#	Routes here will render the user-created mobile sites
	##	
	constraints :subdomain => 'm' do	
		match '/', to: 'mobile_sites#index', via: :get
		match '/:slug', to: 'mobile_sites#show', via: :get, as: 'mobile_site'
	end

	##	
	#	Routes For 'www.octomobi.com'
	#	Routes here are for all pages within the primary domain of the site
	#	including the Admin scope, site-creator (preview and main), and user
	#	management
	## 
	root to: "home_page#index"

	scope :admin do
		devise_for :admins
	end
	
	devise_for :customers, path: "user", controllers:  {registrations: 'registrations', 
											sessions: 'sessions'}

	resources :site_creator, only: [:new, :create, :edit, :update, :destroy]

	resources :subscriptions

	match '/user/dashboard',	to: 'customers#dashboard', via: :get, as: 'customer_dashboard'


		
end
