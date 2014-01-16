@devit
#language it
Funzonlità: cerca
    Scenario: cerca_una_stringa
        Dato che sono su Google
        E cerco "sergio boso"
        Allora il titolo deve contenere "sergio boso"
        E la pagine deve contenere un link con il testo "Consulenze Infrastruttura Informatica Ing. Boso"
        Quando clicko sul testo "Consulenze Infrastruttura Informatica Ing. Boso"
        Allora il titolo deve contenere "Consulenze Infrastruttura Informatica"