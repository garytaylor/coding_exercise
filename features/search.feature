Feature: Search
  In order to make sure I dont leave the site and take my money elsewhere
  As a customer searching the site
  I want to be able to find properties easily and be offered alternatives if a property is then rented out
  Scenario:  A user searches the site for "Sizeable house" but this is already rented so the system suggests alternatives
    Given I am a customer
    And there are the default 5 properties in the database
    And property "Sizeable house" has been rented out
    And I am on the property search page
    When I search for a property called "Sizeable house"
    And I press the search button
    Then the alternatives should list the following properties only and in this order:
      | name                      | bedroom_count   | distance        |
      | Flat with stunning view   | 2               | 3.9 km          |
      | Trendy flat               | 2               | 5.1 km         |
  Scenario:  A user searches the site for "Trendy flat" but this is already rented so the system suggests alternatives
    Given I am a customer
    And there are the default 5 properties in the database
    And property "Trendy flat" has been rented out
    And I am on the property search page
    When I search for a property called "Trendy flat"
    And I press the search button
    Then the alternatives should list the following properties only and in this order:
      | name                      | bedroom_count   | distance        |
      | Sizeable house            | 2               | 5.1 km          |
      | Flat with stunning view   | 2               | 8.5 km          |
  Scenario:  A user searches the site for "Flat with stunning view" but this is already rented so the system suggests alternatives
    Given I am a customer
    And there are the default 5 properties in the database
    And property "Flat with stunning view" has been rented out
    And I am on the property search page
    When I search for a property called "Flat with stunning view"
    And I press the search button
    Then the alternatives should list the following properties only and in this order:
      | name                      | bedroom_count   | distance        |
      | Sizeable house            | 2               | 3.9 km          |
      | Trendy flat               | 2               | 8.5 km          |
  Scenario:  A user searches the site for "Unique flat" but this is already rented so the system suggests alternatives
    Given I am a customer
    And there are the default 5 properties in the database
    And property "Unique flat" has been rented out
    And I am on the property search page
    When I search for a property called "Unique flat"
    And I press the search button
    Then the alternatives should list the following properties only and in this order:
    | name                      | bedroom_count   | distance        |
    | Flat with stunning view   | 2               | 6.3 km          |
    | Sizeable house            | 2               | 9.8 km          |
    | Trendy flat               | 2               | 13.4 km         |
  Scenario:  A user searches the site for "Isolated house" but this is already rented so the system suggests alternatives but finds none
    Given I am a customer
    And there are the default 5 properties in the database
    And property "Isolated house" has been rented out
    And I am on the property search page
    When I search for a property called "Isolated house"
    And I press the search button
    Then the alternatives list should be empty

