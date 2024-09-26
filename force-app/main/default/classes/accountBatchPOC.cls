global class accountBatchPOC implements Database.Batchable<sObject>,brf_BatchableErrorHandler{
    
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id, Is_Affiliated__c,SLASerialNumber__c, name from Account where Is_Affiliated__c=false';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope) {
    list<contact> cclist=new list<contact>();
        for(Account a : scope)
        {
           if(a.id=='0010o00002p8n32'){
           contact cc = new contact();
           cc.lastname ='test';
           cc.AccountId=a.id;
           cc.Describe__c='fagsdgsdfgsdgdsgg';
           cclist.add(cc);
        }
        }
       // update scope;
        Database.Insert(cclist, true);
    }
    
    global void finish(Database.BatchableContext BC) {
        
       
    }
     public void handleErrors(brf_BatchableError error) {
       }
           
             
    
}