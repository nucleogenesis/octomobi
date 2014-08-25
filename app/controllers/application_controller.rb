class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Pricing class default set here-- this class is hidden and 
  # brought up in a modal unless the user is on the home_page
  @pricing_class = "pricing"
end
