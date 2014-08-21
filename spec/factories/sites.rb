# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
	  title "MY SITE"
	  customer_id 1
	  basic_redirect "My site"
	  google_analytics_api_key "UAxXXXXX"
  end
end
