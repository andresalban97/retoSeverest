@updateUser
Feature: Actualizar Usuario

    Background: Url Definition and Function
        * def dataGenerator = Java.type('com.severestApp.utils.DataGenerate')
        * def idUserResponse = call read('classpath:features/users/listUser.feature')
        * def UserSelector = Java.type('com.severestApp.utils.UserSelector')
        * def idUsers = idUserResponse.AllUsers
        * def userQuantidade = idUserResponse.idQuantidade
        * def username = dataGenerator.generateName()
        * def email = dataGenerator.generateEmail()
        * def password = dataGenerator.generatePassword()
        * def isAdministratorRandom = dataGenerator.getRandomisAdministrator()
       
        

        Given url ApiUrl
        Given path 'usuarios'
    
    Scenario: Update Existing User successfully
        * def randomIndex = dataGenerator.generateRandomNumberInt(userQuantidade)
        * def selectUser = idUsers[randomIndex]
        * def idUser = selectUser._id
        * def updateUser = 
        """
        { 
        nome: #(username) , 
        email: #(email), 
        password: #(password),
        administrador: #(isAdministratorRandom)
        }
        """
        Given path idUser
        And request updateUser
        When method put
        Then status 200
        And match response == { message: 'Registro alterado com sucesso' }

     Scenario: Create New User if ID not found
        * def randomIdUser = dataGenerator.generateRandomId(16)
        * def newUser = 
        """
        { 
        nome: #(username) , 
        email: #(email), 
        password: #(password),
        administrador: #(isAdministratorRandom)
        }
        """
        Given path randomIdUser
        And request newUser
        When method put
        Then status 201
        And match response == 
        """
        {
            "message": "Cadastro realizado com sucesso",
            "_id": #string
        }
        """

     Scenario: Fail updating user due to duplicate email
        * def randomIndex  = dataGenerator.generateRandomNumberInt(userQuantidade)
        * def randomIdUser  = dataGenerator.generateRandomId(16)
        * def selectUser    = idUsers[randomIndex]
        * def existingEmail = idUsers.find(x => x._id != selectUser._id)
        * def updateUser    = 
        """
            { 
                nome: #(username) , 
                email: #(existingEmail.email), 
                password: #(password),
                administrador: #(isAdministratorRandom)
            }
        """
        Given path randomIdUser
        And request updateUser
        When method put
        Then status 400
        And match response == { message: 'Este email já está sendo usado' }