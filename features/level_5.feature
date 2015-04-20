Feature: Manage items
  As an administrator
  I want to be able to manage information on items
  So customers have items they can order from Bread Express

  Background:
    Given an initial setup
  
  # READ METHODS
  Scenario: No active items yet
    Given no setup yet
    Given a logged-in admin
    When I go to the items page
    Then I should see "No active items at this time"
    And I should not see "Name"
    And I should not see "Price"
    And I should not see "Units"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View all items
    Given a logged-in admin
    When I go to the items page
    Then I should see "Available Items"
    And I should see "Name"
    And I should see "Price"
    And I should see "Units"
    And I should see "Challah Bread"
    And I should see "Chocolate Zucchini Muffins"
    And I should see "Crossiants"
    And I should see "$5.75"
    And I should see "$9.25"
    And I should see "$9.50"
    And I should see "1 loaf"
    And I should see "12 muffins"
    And I should see "4 pastries"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View item details as admin
    Given a logged-in admin
    When I go to Challah Bread details page
    Then I should see "Challah Bread"
    And I should see "This is a Jewish egg bread that's braided for a beautiful presentation. We top ours with poppy seeds for a special touch."
    And I should see "$5.75"
    And I should see "Total weight: 0.9 lbs."
    And I should see "Price History"
    And I should see "$5.50"
    And I should see "$4.95"
    And I should not see "Chocolate Zucchini Muffins"
    And I should not see "Crossiants"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"

  Scenario: View item details as customer
    Given a logged-in customer
    When I go to Challah Bread details page
    Then I should see "Challah Bread"
    And I should see "This is a Jewish egg bread that's braided for a beautiful presentation. We top ours with poppy seeds for a special touch."
    And I should see "$5.75"
    And I should see "Total weight: 0.9 lbs."
    And I should see "Similar Items"
    And I should see "Apple Cherry Bread"
    And I should see "Cinnamon Swirl Bread"
    And I should not see "Price History"
    And I should not see "$5.50"
    And I should not see "$4.95"
    And I should not see "Chocolate Zucchini Muffins"
    And I should not see "Crossiants"
    And I should not see "true"
    And I should not see "True"
    And I should not see "ID"
    And I should not see "_id"
    And I should not see "Created"
    And I should not see "created"
        
  
  # CREATE METHODS
  Scenario: Creating a new item is successful
    Given a logged-in admin
    When I go to the new item page
    Then I should see "Picture"
    When I fill in "item_name" with "Pumpernickel"
    And I fill in "item_description" with "Pumpernickel is a typically heavy, slightly sweet rye bread traditionally made with coarsely ground rye. Our pumpernickel is made with a combination of rye flour and whole rye berries."
    And I select "Bread" from "item_category"
    And I fill in "item_weight" with "1.2"
    And I fill in "item_units_per_item" with "1"
    And I press "Create Item"
    Then I should see "Pumpernickel was added to the system"
    And I should see "Pumpernickel is a typically heavy, slightly sweet rye bread traditionally made with coarsely ground rye. Our pumpernickel is made with a combination of rye flour and whole rye berries."
    And I should see "Total weight: 1.2 lbs."

  Scenario: Creating a new item fails if not an admin
    Given a logged-in customer
    When I go to the new item page
    Then I should see "You are not authorized to take this action"
    And I should not see "Description"

  