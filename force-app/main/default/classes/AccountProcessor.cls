public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> recordIds) {
        
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();
        
        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) total
            FROM Contact
            WHERE AccountId IN :recordIds
            GROUP BY AccountId
        ]) {
            contactCountMap.put(
                (Id) ar.get('accId'),
            (Integer) ar.get('total')
                );
        }
        
        List<Account> accountsToUpdate = [
            SELECT Id, Number_Of_Contacts__c
            FROM Account
            WHERE Id IN :recordIds
        ];
        
        for (Account acc : accountsToUpdate) {
            acc.Number_Of_Contacts__c =
                contactCountMap.containsKey(acc.Id)
                ? contactCountMap.get(acc.Id)
                : 0;
        }
        
        update accountsToUpdate;
    }
}