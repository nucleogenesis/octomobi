OctomobiRails::Application.routes.draw do
	root to: "home#index"

	scope :admin do
		devise_for :admins
	end

	devise_for :customers, path: "user"
end
