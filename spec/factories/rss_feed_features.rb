# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :rss_feed_feature do
    title "MyString"
    feed_url "MyString"
    entries_to_show 1
  end
end
