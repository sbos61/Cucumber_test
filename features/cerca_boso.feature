@boh
Feature: cerca
    Scenario: cerca_una_stringa
        Given I am on Google
        And I search "sergio boso"
        Then the title should contain "sergio boso"
        Then the page should contain a link with text "Consulenze Infrastruttura Informatica Ing. Boso"
        When I click on text "Consulenze Infrastruttura Informatica Ing. Boso"
        Then the title should contain "Consulenze Infrastruttura Informatica"