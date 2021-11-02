public class lightningDemo {
@AuraEnabled
    public static String NameMethod(){
        String Name='faizan';
        return Name;
    }
    
    @AuraEnabled
    public static list<Account> AccRecords(){
        list<Account> acc =[Select id,Description,Name from Account limit 10];
        return acc;
    }
    
}