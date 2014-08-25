# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
	  title "MY SITE"
	  customer_id 1
	  basic_redirect "My site"
	  pro_redirect nil
	  google_analytics_api_key "UAxXXXXX"
	  desktop_site_url nil
	  logo_location "www.mysite.com/image/logo.png"
  end
end
