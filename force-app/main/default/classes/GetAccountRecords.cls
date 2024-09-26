public class GetAccountRecords {
    
    @AuraEnabled
    public static list<Account> Getrecords(){
        list<Account> acc =[Select id, Name, Description from Account limit 5];
        return acc;
    }

}