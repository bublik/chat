FactoryGirl.define do
  factory :user do
    username { 'username' }
    password "123456abc!ABC"

    trait :online do
      state true
    end

  end
end