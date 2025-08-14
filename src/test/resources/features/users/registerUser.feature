
Feature: Registrar Usuario

    Background: Url Definition and Function
        * def dataGenerator = Java.type('com.severestApp.utils.DataGenerate')
        * def username = dataGenerator.generateName()
        * def email = dataGenerator.generateEmail()
        * def password = dataGenerator.generatePassword()
        Given url ApiUrl
        Given path 'usuarios'
       
    @smoke @regression
    Scenario: User registration successful 
        Given request 
        """
            {
                "nome": "#(username)",
                "email": "#(email)",
                "password": "#(password)",
                "administrador": "#(isAdministrator)"
            }
        """
        When method post
        Then status 201

    @regression
    Scenario: User registration with existing email 
        Given request 
        """
            {  
                "nome": "#(username)",
                "email": "#(existingEmail)",
                "password": "#(password)",
                "administrador": "#(isAdministrator)"
            }
        """
        When method post
        Then status 400