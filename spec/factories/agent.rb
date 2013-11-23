FactoryGirl.define do
  factory :agent do
    name { Faker::Name.first_name }
    sequence(:email) { |n| "#{n}"+Faker::Internet.email }
    user { FactoryGirl.build(:user, username: 'username') }
    password "123456abc!ABC"
    password_confirmation "123456abc!ABC"
    sign_in_count 1

  end
end