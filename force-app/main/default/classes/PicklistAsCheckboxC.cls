public class PicklistAsCheckboxC {
    
    @AuraEnabled 
    public static void saveAccount(Account acc){
        insert acc;
    }
}