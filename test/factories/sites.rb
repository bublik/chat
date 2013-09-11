# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site do
    name "MyString"
    domain "MyString"
    site_category nil
    color "MyString"
    side "MyString"
    position "MyString"
    title_online "MyString"
    title_offline "MyString"
    collect_stats false
    show_online false
    show_offline false
    auto_open false
    disabled false
  end
end
