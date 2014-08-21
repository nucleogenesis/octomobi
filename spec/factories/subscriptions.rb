# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subscription do
    customer_id 1
    is_active false
    auto_payment false
    subscription_type "MyString"
    payment_due_date "2014-08-19 16:09:16"
    expiry_date "2014-08-19 16:09:16"
  end
end
