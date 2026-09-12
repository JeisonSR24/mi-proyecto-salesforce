@isTest
public class AccountProcessorTest {
    
    @isTest
    static void testCountContacts() {
        
        List<Account> testAccounts = new List<Account>();
        
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(
                new Account(Name = 'Test Account ' + i)
                );
        }
        
        insert testAccounts;
        
        List<Contact> contacts = new List<Contact>();
        
        // Solo agregar contactos a las primeras 4 cuentas
        for (Integer i = 0; i < 4; i++) {
            
            contacts.add(
                new Contact(
                LastName = 'Contact 1',
            AccountId = testAccounts[i].Id
                )
                );
            
            contacts.add(
                new Contact(
                LastName = 'Contact 2',
            AccountId = testAccounts[i].Id
                )
                );
        }
        
        insert contacts;
        
        List<Id> accountIds = new List<Id>();
        
        for (Account acc : testAccounts) {
            accountIds.add(acc.Id);
        }
        
        Test.startTest();
        
        AccountProcessor.countContacts(accountIds);
        
        Test.stopTest();
        
        List<Account> updatedAccounts = [
            SELECT Id, Name, Number_Of_Contacts__c
            FROM Account
            WHERE Id IN :accountIds
        ];
        
        for (Account acc : updatedAccounts) {
            
            if (acc.Name == 'Test Account 4') {
                
                System.assertEquals(
                    0,
                acc.Number_Of_Contacts__c
                    );
                
            } else {
                
                System.assertEquals(
                    2,
                acc.Number_Of_Contacts__c
                    );
            }
        }
    }
}