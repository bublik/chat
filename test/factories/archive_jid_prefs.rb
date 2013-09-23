# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :archive_jid_pref do
    with_user "MyString"
    with_resource "MyString"
    save false
    expire 1
    otr false
  end
end
