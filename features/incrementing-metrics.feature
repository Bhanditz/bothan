Feature: Incrementing Metrics

  Background:
    Given I send and accept JSON
    And I set up a Pusher spy

  Scenario: Incrementing by 1
    Given I authenticate as the user "foo" with the password "bar"
    And there is a metric in the database with the name "membership-count"
    And it has a time of "2013-12-25T15:00:00+00:00"
    And it has a value of:
      """
      10
      """
    And I send a POST request to "metrics/membership-count/increment"
    Then the response status should be "201"
    And the Pusher endpoint should have recieved "membership-count" with "updated"
    Then the data should be stored in the "membership-count" metric
    And the value of the metric should be:
      """
      11
      """
