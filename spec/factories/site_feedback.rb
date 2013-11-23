FactoryGirl.define do
  factory :site_feedback do
    username { Faker::Name.name }
    email { Faker::Internet.email }
    phone 'phone string'
    message { Faker::Lorem.paragraph }
    remote_ip '127.0.0.1'
    user_agent 'Mozilla'
  end
end