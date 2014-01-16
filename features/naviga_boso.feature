@stable
Feature: test
    Scenario: test_boso_consulting
        Given I am on bosoconsulting.it
        Then the title should contain "Consulenze Infrastruttura Informatica Ing. Boso"
#        When I click on text "Competenze e valori"
#        Then the title should contain "Competenze e valori"
#        When I click on text "Web Load Testing"
#        Then the title should contain "Web Load Testing"
        When I click on text "Contatti"
        And I write "sergio" "boso" "io" "049111" "sb@test.com" "qwertyuiop"
        And I accept privacy and send
        Then I should see "Il messaggio è stato inviato al nostro staff."
