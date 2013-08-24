# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    name "MyString"
    domain "MyString"
    site_category_id "MyString"
    color "MyString"
    side "MyString"
    position "MyString"
    title_online "MyString"
    title_offline "MyString"
    collect_stats false
    show_offline ""
    show_offline false
    disabled false
  end
end
