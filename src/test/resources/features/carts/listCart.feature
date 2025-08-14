@ignore
Feature: Listar carritos de compras

    Background: Url Definition and Function
        Given url ApiUrl
        Given path 'carrinhos'
    
    Scenario: All Shopping Cart List
        When method get
        Then status 200
        * def idQuantidade = response.quantidade
        * def AllUsersCart = response.carrinhos