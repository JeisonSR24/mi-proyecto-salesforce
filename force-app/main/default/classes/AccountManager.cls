@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    
    @HttpGet
    global static Account getAccount() {
        // Obtener el Account ID de la URL
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
            request.requestURI.indexOf('/Accounts/') + 10,
            request.requestURI.indexOf('/contacts')
        );
        
        // Consultar la cuenta con sus contactos relacionados
        Account account = [
            SELECT Id, Name,
                   (SELECT Id, Name FROM Contacts)
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];
        
        return account;
    }
}