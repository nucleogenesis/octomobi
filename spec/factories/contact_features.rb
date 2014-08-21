# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contact_feature do
    email_contact "MyString"
    phone_contact "MyString"
    fax_contact "MyString"
    address "MyString"
  end
end
