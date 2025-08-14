@searUser
Feature: Buscar Usuario

    Background: Url Definition and Function
        * def idUserResponse = call read('classpath:features/users/listUser.feature')
        * def dataGenerator = Java.type('com.severestApp.utils.DataGenerate')
        * def quantidade = idUserResponse.idQuantidade
        * def randomIndex  = dataGenerator.generateRandomNumberInt(quantidade)
        * def idUser = idUserResponse.AllUsers[randomIndex]._id
        Given url ApiUrl
        Given path 'usuarios'
        Given def schemaUser = read('classpath:schemas/listUserSchema.json')
        

    Scenario: Search User succesfull
        Given path idUser
        When method get
        Then status 200
        And match response == schemaUser


    Scenario Outline: Validate Search User error message
        Given path <idNotExistUser>
        When method get
        Then status 400
        And match response == <erroResponseMessage>

        Examples:
            | idNotExistUser    | erroResponseMessage                                          |
            | 'Value1'          | {"id":"id deve ter exatamente 16 caracteres alfanuméricos"}  |
            | 'Value12345678123'| {"message": "Usuário não encontrado"}                        |

