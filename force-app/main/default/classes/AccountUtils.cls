public class AccountUtils {
    
    public static List<Account> accountsByState(String stateAbbreviation) {
        // Realizamos la consulta filtrando por el campo BillingState
        List<Account> acctList = [SELECT Id, Name FROM Account WHERE BillingState = :stateAbbreviation];
        
        // Retornamos la lista de resultados
        return acctList;
    }
}