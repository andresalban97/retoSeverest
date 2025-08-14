@ignore
Feature: Eliminar Usuario

    Background: Url Definition and Function
        * def idUserCartResponse = call read('classpath:features/carts/listCart.feature')
        * def idUserResponse     = call read('classpath:features/users/listUser.feature')
        * def dataGenerator      = Java.type('com.severestApp.utils.DataGenerate')
        * def UserSelector       = Java.type('com.severestApp.utils.UserSelector')
        * def idUsersWithCart    = idUserCartResponse.AllUsersCart.map(x => { return { idUsuario: x.idUsuario, _id: x._id } })
        * def idWithoutCart      = idUserResponse.AllUsers.filter(x => !idUsersWithCart.map(y => y.idUsuario).includes(x._id))
        
        Given url ApiUrl
        Given path 'usuarios'

    Scenario: Validate Delete User error message
        * def selectUser = new UserSelector().selectRandomUserWithCart(idUsersWithCart)
        * def idUser             = selectUser.idUsuario
        Given path idUser
        When method delete
        Then status 400
        And match response == 
"""
{ 
    "message": "Não é permitido excluir usuário com carrinho cadastrado", 
    "idCarrinho": #(selectUser._id)
} 
"""
    Scenario: Delete User 
        * def selectUser = new UserSelector().selectRandomUserWithoutCart(idWithoutCart)
        * def idUser = selectUser ? selectUser._id : null
        * def responseMessage = selectUser ? { message: "Registro excluído com sucesso" }  : { message: "Nenhum registro excluído" } 
        Given path idUser
        When method delete
        Then status 200
        And match response == responseMessage