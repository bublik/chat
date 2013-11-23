FactoryGirl.define do
  factory :user do
    username { Faker::Name.first_name }
    password "123456abc!ABC"

    trait :online do
      state true
    end

  end
end