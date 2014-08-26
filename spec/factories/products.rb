# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "MyString"
    reference "MyString"
    price 1
    payment_period "MyString"
  end
end
