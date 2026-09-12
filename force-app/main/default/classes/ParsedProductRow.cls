public class ParsedProductRow {
    @AuraEnabled public String productCode;
    @AuraEnabled public String productName;
    @AuraEnabled public Decimal quantity;
    @AuraEnabled public Decimal unitPrice;
    @AuraEnabled public String pricebookEntryId;
}