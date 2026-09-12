@isTest
public class AccountManagerTest {
    
    @testSetup
    static void setupTestData() {
        // Crear cuenta de prueba
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        // Crear contactos de prueba asociados a la cuenta
        List<Contact> testContacts = new List<Contact>{
            new Contact(
                FirstName = 'John',
                LastName = 'Doe',
                AccountId = testAccount.Id
            ),
            new Contact(
                FirstName = 'Jane',
                LastName = 'Smith',
                AccountId = testAccount.Id
            ),
            new Contact(
                FirstName = 'Bob',
                LastName = 'Johnson',
                AccountId = testAccount.Id
            )
        };
        insert testContacts;
    }
    
    @isTest
    static void testGetAccountWithContacts() {
        // Obtener la cuenta de prueba
        Account testAccount = [SELECT Id FROM Account WHERE Name = 'Test Account' LIMIT 1];
        
        // Configurar el contexto REST
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' 
                           + testAccount.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Llamar al método REST
        Test.startTest();
        Account result = AccountManager.getAccount();
        Test.stopTest();
        
        // Verificar los resultados
        System.assertNotEquals(null, result, 'Account should not be null');
        System.assertEquals(testAccount.Id, result.Id, 'Account ID should match');
        System.assertEquals('Test Account', result.Name, 'Account name should match');
        
        // Verificar que se devolvieron los contactos
        System.assertNotEquals(null, result.Contacts, 'Contacts list should not be null');
        System.assertEquals(3, result.Contacts.size(), 'Should return 3 contacts');
        
        // Verificar que los contactos tienen los campos correctos
        for (Contact contact : result.Contacts) {
            System.assertNotEquals(null, contact.Id, 'Contact ID should not be null');
            System.assertNotEquals(null, contact.Name, 'Contact name should not be null');
        }
        
        // Verificar nombres específicos de contactos
        Set<String> contactNames = new Set<String>();
        for (Contact contact : result.Contacts) {
            contactNames.add(contact.Name);
        }
        System.assert(contactNames.contains('John Doe'), 'Should contain John Doe');
        System.assert(contactNames.contains('Jane Smith'), 'Should contain Jane Smith');
        System.assert(contactNames.contains('Bob Johnson'), 'Should contain Bob Johnson');
    }
    
    @isTest
    static void testGetAccountWithoutContacts() {
        // Crear una cuenta sin contactos
        Account accountWithoutContacts = new Account(Name = 'Account Without Contacts');
        insert accountWithoutContacts;
        
        // Configurar el contexto REST
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' 
                           + accountWithoutContacts.Id + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Llamar al método REST
        Test.startTest();
        Account result = AccountManager.getAccount();
        Test.stopTest();
        
        // Verificar los resultados
        System.assertNotEquals(null, result, 'Account should not be null');
        System.assertEquals(accountWithoutContacts.Id, result.Id, 'Account ID should match');
        System.assertEquals('Account Without Contacts', result.Name, 'Account name should match');
        
        // Verificar que la lista de contactos esté vacía
        System.assertNotEquals(null, result.Contacts, 'Contacts list should not be null');
        System.assertEquals(0, result.Contacts.size(), 'Should return 0 contacts');
    }
    
    @isTest
    static void testGetAccountInvalidId() {
        // Crear un ID ficticio (pero válido en formato)
        String fakeAccountId = '001000000000000AAA';
        
        // Configurar el contexto REST
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/' 
                           + fakeAccountId + '/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        // Llamar al método REST y esperar una excepción
        Test.startTest();
        try {
            Account result = AccountManager.getAccount();
            System.assert(false, 'Should have thrown an exception for invalid account ID');
        } catch (QueryException e) {
            // Se espera esta excepción
            System.assert(true, 'QueryException was expected for invalid account ID');
        }
        Test.stopTest();
    }
}