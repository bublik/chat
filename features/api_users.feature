Feature: Api Users controller
  We should can to change online status for user.

  Scenario: Successful change state
  Api requests with HTTP BAse Athorization should can change user status

    Given I have correct HTTP BASE authorization settings
    Given I have jabber user
    When I send post request to "online" action with "user_name" param
    Then I should have state as "online" for user "user_name"

    Given I have correct HTTP BASE authorization settings
    When I send post request to "offline" action with "user_name" param
    Then I should have state as "offline" for user "user_name"
