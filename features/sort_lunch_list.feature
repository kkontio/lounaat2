Feature: Sort the lunch list alphabetically

  As a hungry worker
  In order to be able to browse the lunch list more efficiently
  I want the list to be sorted alphabetically

Background: Restaurants and lunches have been added to the database

  Given the following restaurants exist:
    | name        |
    | Retro       |
    | Bar Fennia  |
    | Kotipizza   |
    | Rax         |

  And there's "Maksalaatikko" served for lunch at "Retro" today
  And there's "Paistetut muikut" served for lunch at "Bar Fennia" today
  And there are no special lunch items at "Kotipizza" today
  And there are no special lunch items at "Rax" today

  And I am on the home page

Scenario: Restaurants with lunch items should be listed before ones without
  Then I should see "Retro" before "Kotipizza"
  And I should see "Retro" before "Rax"
  And I should see "Bar Fennia" before "Kotipizza"
  And I should see "Bar Fennia" before "Rax"

Scenario: Restaurants with lunch items should sorted alphabetically
  Then I should see "Bar Fennia" before "Retro"

Scenario: Restaurants without lunch items should be sorted alphabetically
  Then I should see "Kotipizza" before "Rax"