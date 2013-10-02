# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :site_feedback do
    username "MyString"
    email "MyString"
    phone "MyString"
    message "MyText"
    remote_ip "MyString"
    user_agent "MyString"
    site_id 1
  end
end
