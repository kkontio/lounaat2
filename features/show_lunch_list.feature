Feature: Display list of restaurants and lunches

  As a hungry worker
  I want to see a list of all lunches available in the neighborhood
  So that I can easily select the best place to eat lunch

Background: Restaurants and lunches have been added to the database

  Given the following restaurants exist:
  | name  |
  | Retro |
  | Lokki |

  And lunches are available for today

  And I am on the home page

Scenario: View lunch options for today
  Given I am on the home page
  Then I should see "Retro" on today's lunch list
  And I should see "Lokki" on today's lunch list