FactoryGirl.define do
  factory :site do
    name { Faker::Internet.domain_name }
    domain { Faker::Internet.domain_name }
    offline_welcome_message { Faker::Lorem.words(3).to_s }
    before(:create)  do |site|
      site.agent = FactoryGirl.create(:agent)
    end
  end
end

