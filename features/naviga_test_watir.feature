@stable
Feature: test
    Scenario: test_su_watir
        Given I am on watir-example
        Then the title should contain "Watir Example"
        And I use "Firefox" as browser
        And I'm happy at 3
        And OS is at 5 for "Item 1"
        And OS is at 4 for "Item 2"
        And I write "sergio boso" to text field
      And I write "qwertyuiop" to textbox
      And I select "Watir" as testing tool
      And I like "Ruby" as language
      And I like "Python" as language
      And I press "Invia"
      Then I should see "Si sono verificati problemi, ma non ti preoccupare."
