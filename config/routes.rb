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

	# Customers Dashboard Routes
	match '/user/dashboard', to: 'customers#dashboard', via: :get, as: 'customer_dashboard'
	match '/user/sites', to: 'customers#sites', via: :get, as: 'customer_sites'
	match '/user/account', to: 'customers#account', via: :get, as: 'customer_account'

	# Customer Subscriptions
	match '/user/subscription/new', to: 'subscriptions#create_pending', via: :post,
		as: 'new_subscription'
	match '/user/subscription/activate/:customer_id', to: 'subscriptions#activate',
		via: :post, as: 'activate_subscription'
	match '/user/subscription/deactivate/:customer_id', to: 'subscriptions#deactivate',
		via: :post, as: 'deactivate_subscription'


	#Site Creator (Preview / Production)
	resources :site_creator, only: [:new, :create, :edit, :update, :destroy], path: '/site-creator'
	match 'site-creator/customer-type', to: 'site_creator#customer_type', via: :get
	match 'site-creator/form', to: 'site_creator#form', via: :get
	match 'site-creator/parse', to: 'site_creator#parse', via: :get, 
		as: 'site_creator_parser'

	# Pages (Retail & Reseller Pricing)
	match '/pages/pricing', to: 'pages#retailer_pricing', via: :get,
		as: 'retail_pricing'
	match '/pages/reseller-pricing', to: 'pages#reseller_pricing', via: :get, 
		as: 'reseller_pricing'

	resources :subscriptions

end
