Feature: Api Users controller
  We should can to change online status for user.

  Scenario: Successful change state
  Api requests with HTTP BAse Athorization should can change user status

    Given I have correct HTTP BASE authorization settings
    Given I have jabber user
    When I send post request to "online" action with "username" param
    Then I should have state as "online" for user "username"

    Given I have correct HTTP BASE authorization settings
    When I send post request to "offline" action with "username" param
    Then I should have state as "offline" for user "username"
