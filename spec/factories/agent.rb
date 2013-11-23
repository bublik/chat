FactoryGirl.define do
  factory :agent do
    name { Faker::Name.first_name }
    sequence(:email) { |n| "#{n}"+Faker::Internet.email }
    plan { FactoryGirl.create(:plan) }
    password "123456abc!ABC"
    password_confirmation "123456abc!ABC"
    sign_in_count 1

    factory :agent_with_user do
      after(:create) { |instance| FactoryGirl.create(:user, agent: instance) }
    end

  end
end