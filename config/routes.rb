OctomobiRails::Application.routes.draw do
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
	
	# Home Page
	root to: "home_page#index"

	# Admin Section
	scope :admin do
		devise_for :admins
	end

	# Customer Sessions & Registrations For Custom Controllers
	devise_for :customers, path: "user", controllers:  {registrations: 'registrations', 
													 sessions: 'sessions'}
	#Site Creator (Preview / Production)
	resources :site_creator, only: [:new, :create, :edit, :update, :destroy]
	resources :site_creator_preview, only: [:new, :create]

	# Pages (Retail & Reseller Pricing)
	match '/pages/pricing', to: 'pages#retailer_pricing', via: :get,
		as: 'retail_pricing'
	match '/pages/reseller-pricing', to: 'pages#reseller_pricing', via: :get, 
		as: 'reseller_pricing'

	resources :subscriptions

	match '/user/dashboard',	to: 'customers#dashboard', via: :get, as: 'customer_dashboard'



end
