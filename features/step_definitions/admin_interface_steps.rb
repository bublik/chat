Given(/^I signed up$/) do
  @agent = FactoryGirl.create(:agent)
  sign_in @agent
end

Given(/^I have chosen to management page$/) do
  visit(management_index_path)
end

Given(/^I should see management header links$/) do
  expect(page).to have_content I18n.t('layouts.management.settings')
end

Then(/^I should not have management links$/) do
  expect(page).to_not have_content I18n.t('layouts.management.settings')
end

When(/^I dont have any site$/) do
  Site.destroy_all
end

Given(/^I have chosen to sites link$/) do
  visit(sites_path)
end


Then(/^I should see new user form$/) do
  page.should have_selector('#new_user #user_username')
end

Then(/^I should create Jabber user$/) do
  within("#new_user") do
    fill_in "user[username]", :with => 'newuser'
    fill_in "user[password]", :with => 'newuser_password'
    click_button I18n.t('global.send')
  end
end

Then(/^I should see new site form$/) do
  expect(page).to have_content I18n.t('sites.new.add_site')
  page.should have_selector('#new_site #site_name')
end

Given(/^I have chosen to messages history page$/) do
  visit(archive_collections_path)
end

Given(/^I have chosen to offline messages page$/) do
  visit(visitor_feedbacks_path)
end

