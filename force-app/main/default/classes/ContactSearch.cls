public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String LastName, String MailingPostalCode) {
        List<Contact> contacts = new List<Contact>();
        
        try {
            contacts = [SELECT Id, Name, LastName, MailingPostalCode FROM Contact WHERE LastName = :LastName AND MailingPostalCode = :MailingPostalCode];
            System.debug('Found ' + contacts.size() + ' contacts matching criteria.');
        } catch (Exception e) {
            System.debug('Error searching for contacts: ' + e.getMessage());
        }
        
        return contacts;
        
    }
}