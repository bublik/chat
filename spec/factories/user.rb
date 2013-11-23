FactoryGirl.define do
  factory :user do
    username { 'user_name' }
    password "123456abc!ABC"

    trait :online do
      state true
    end

  end
end