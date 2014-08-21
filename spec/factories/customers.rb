# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :customer do
	  first_name "James"
	  last_name "Thompson"
	  email "james@thompson.com"
	  phone_number "876-5309"
	  password "password"
	  password_confirmation "password"
	  confirmed_at "#{Time.now}"
  end
end
