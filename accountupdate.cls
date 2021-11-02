global class accountupdate implements Database.Batchable<sObject>,schedulable{

    list<Account> abb = new list<Account>();
    global String setDays = system.now().adddays(14).format('ss mm HH dd MM ? yyyy');
    global String EOL_Life = 'EOL_Life';
    global String EOL_Life1 = 'EOL_Life1';
    global String EOL_Life2 = 'EOL_Life1';
    global String EOL_Life2 = 'EOL_Life2 ';
    global String EOL_Life3 = 'EOL_Life22 ';
    global String EOL_Life3 = 'EOL_Li4fe22 ';





    global Database.QueryLocator start(Database.BatchableContext BC){
        string query ='select id,name from Account where NumberofLocations__c = 2';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC,List<Account> acc){
    
        for(Account act:acc){

         act.Revenue__c = 2000;
         abb.add(act);
        }
    update abb;
    }
    
    global void finish(Database.BatchableContext BC){
    
        list<CronJobDetail> detailId = [SELECT Id FROM CronJobDetail WHERE Name=:EOL_Life];
        if (detailId.size()>0) {
            CronTrigger jobId = [SELECT Id from CronTrigger WHERE CronJobDetailId =: detailId[0].Id];
            System.abortJob(jobId.id);
        } 
        
        System.schedule(EOL_Life,setDays,new scheduleAccount()); 
    }
    
    global void execute(Schedulablecontext sc){
        accountupdate executeBatchApex = new accountupdate();
        database.executeBatch(executeBatchApex,200);
    }
    
}
