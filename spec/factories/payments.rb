# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    customer_id 1
    subscription_id 1
    amount 1
    successful false
    coupon_code "MyString"
  end
end
