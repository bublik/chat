Given(/^I have correct HTTP BASE authorization settings$/) do
  authorize APP_CONFIG['api']['base_user'], APP_CONFIG['api']['base_password']
end

Given(/^I have jabber user$/) do
  agent = FactoryGirl.create(:agent)
  @user = FactoryGirl.create(:user, agent: agent)
end

When(/^I send post request to "(.+)" action with "(.+)" param$/) do |action, username|
  @username = username
  post("/api/users/#{action}", user: username)
end

Then(/^I should have state as "(.+)" for user "(.+)"$/) do |state, user|
  visit("/api/users/state/#{user}")
  expect(page).to have_content(state)
  User.find_by_username(user).get_state.should eq(state)
end
