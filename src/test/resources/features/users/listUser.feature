
Feature: Listar Usuarios
    
    Background: Url Definition and Function
        Given url ApiUrl
        Given path 'usuarios'
        Given def schemaUser = read('classpath:schemas/listUserSchema.json')
    
    @smoke @regression
    Scenario: Get Users 
        Given params { administrador: '#(isAdministrator)' }
        When method get
        Then status 200
        And match response.quantidade == '#number'
        And match response.usuarios == '#[] schemaUser'
        * def idQuantidade = response.quantidade
        * def AllUsers = response.usuarios