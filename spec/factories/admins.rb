# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
	  first_name "Jacob"
	  last_name "Pierce"
	  email "jacob@pierce.com"
	  password "password"
	  password_confirmation "password"
  end
end
