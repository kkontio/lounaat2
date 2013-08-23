Feature: Voting for restaurants

  As a hungry democrat
  I want to be able to cast my vote for a restaurant
  So that me and my hungry colleagues can collectively select the best place to eat

  Background: Restaurants have been added to the database

    Given the following restaurants exist:
      | name  |
      | Retro |

  Scenario: Vote for restaurant to have lunch at
    Given lunches are available for today
    And I am on the home page
    When I vote for "Retro" for today's lunch
    Then I should see vote for "Retro" for today