# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :archive_collection do
    us "MyString"
    with_user "MyString"
    utc "2013-09-22 19:37:54"
    change_by "MyString"
    change_utc "2013-09-22 19:37:54"
  end
end
