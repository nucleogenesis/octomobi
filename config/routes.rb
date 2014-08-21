OctomobiRails::Application.routes.draw do
  devise_for :guests
  get "site_creator/preview"
  get "site_creator/new"
  get "site_creator/create"
  get "site_creator/edit"
  get "site_creator/update"
  get "site_creator/destroy"
  get "home_page/index"
	root to: "home#index"

	scope :admin do
		devise_for :admins
	end

	devise_for :customers, path: "user"
end
