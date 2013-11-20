Given(/^I have chosen to sign up$/) do
  FactoryGirl.create(:plan)
  visit(signup_path)
end

When(/^I sign up with valid details$/) do
  within("#content #new_agent") do
    fill_in "agent[email]", :with => 'newuser@gg.com'
    fill_in "agent[password]", :with => 'newuser_password'
    fill_in "agent[password_confirmation]", :with => 'newuser_password'
    click_button I18n.t('global.send')
  end

end

Then(/^I should see a personalized greeting message$/) do
  expect(page).to have_content 'Вы успешно зарегистрировались'
end

Given(/^I enter an email address that has already registered$/) do
  @agent = FactoryGirl.create(:agent)
  within("#content #new_agent") do
    fill_in "agent[email]", :with => @agent.email
    fill_in "agent[password]", :with => 'newuser_password'
    fill_in "agent[password_confirmation]", :with => 'newuser_password'
    click_button I18n.t('global.send')
  end
end

Then(/^I should be told that the email is already registered$/) do
  #page.should(have_content(column))
  expect(page).to have_content I18n.t('errors.messages.taken')
end

Then(/^I should be offered the option to recover my password$/) do
  expect(page.find('#content')).to have_content I18n.t('devise.titles.reset_password')
end

