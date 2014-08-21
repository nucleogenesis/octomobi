# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :gallery_image do
    image_gallery_feature_id 1
    image_location "MyString"
    alt "MyString"
    link_to "MyString"
  end
end
