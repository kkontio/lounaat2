Feature: Filter lunch list by date

  As a hungry and busy worker
  I want to only see upcoming lunches for the week
  So that I don't have to scroll through a lot of useless information

Background: Restaurants and lunches have been added to the database

  Given the following restaurants exist:
    | name  |
    | Retro |
    | Lokki |

  And there are lunches for the previous week and the following two weeks

  And I am on the home page

Scenario: I should see only lunches for the coming week
  Then I should see lunches for the coming week
  And I should not see lunches for yesterday
  And I should not see lunches seven days in the future