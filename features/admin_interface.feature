Feature: Admin Interface

  Scenario: Guest
    Given I have chosen to management page
    Then I should not have management links

    Given I have chosen to sites link
    Then I should not have management links

    Given I have chosen to messages history page
    Then I should not have management links

    Given I have chosen to offline messages page
    Then I should not have management links

  Scenario: Signed in
  Signed user should see management pages.

    Given I have chosen to sign up
    When I sign up with valid details
    Then I should see new user form
    And I should create Jabber user

    Given I have chosen to management page
    And I should see management header links

    When I dont have any site
    Given I have chosen to sites link
    Then I should see new site form
    And I should see management header links
    Given I have chosen to messages history page
    And I should see management header links
    Given I have chosen to offline messages page
    And I should see management header links


