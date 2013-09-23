# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :archive_message do
    utc "2013-09-22 19:18:27"
    dir false
    body "MyText"
    name "MyString"
  end
end
