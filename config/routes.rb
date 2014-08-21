OctomobiRails::Application.routes.draw do
  get "site_creator_preview/new"
  get "site_creator_preview/create"
  get "site_creator_preview/edit"
  get "site_creator_preview/update"
	##	
	#	Routes For 'www.octomobi.com'
	#	Routes here are for all pages within the primary domain of the site
	#	including the Admin scope, site-creator (preview and main), and user
	#	management
	## 
	root to: "home#index"

	scope :admin do
		devise_for :admins
	end
	
	devise_for :customers, path: "user"
	devise_for :guests

	resources :site_creator, only: [:new, :create, :edit, :update, :destroy]
	match '/site-creator/preview',		to: 'site_creator#preview', via: :get,
		as: 'site_creator_preview'
	match '/site-create/preview/:slug', to: 'site_creator#preview_review', via: :get,
		as: 'site_creator_review'

	resources :subscriptions



	##
	#	Routes for 'm.octomobi.com'
	#	Routes here will render the user-created mobile sites
	##
	
	# match /:slug to mobile_sites#show via get
end
