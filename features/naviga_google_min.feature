@stable
Feature: minimal
    Scenario: vai su Google
        Given I am on Google
        Then the title should contain "Google"