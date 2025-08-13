
Feature: Listar Usuarios
    
    Background: 
        Given url ApiUrl
        Given path 'usuarios'

    Scenario: Get Users
        Given params { _id: '1', nome: '10', email: 'dasd@test.com', password: '10', administrador: 'true' }
        When method get
        Then status 200
        And match response.quantidade == '##number'
        And match response.usuarios == '##[]'