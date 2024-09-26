global class Myjobsuccess implements database.Batchable<sObject>,database.stateful {
    
    global Set<Id> failureIdsSet;
    global integer countTimes=0;
    
    global Myjobsuccess(set<id> failedIds,integer countTimes){
      this.failureIdsSet = failedIds;
      this.countTimes = countTimes;
    }
    
    global Myjobsuccess(){
      failureIdsSet = new set<id>();
    }
    
    global database.QueryLocator start(database.BatchableContext bc){
    string query;
    string Prospect;
        if(!failureIdsSet.isEmpty()){
         Prospect = 'Prospect';
         query = 'select id, Type,SLASerialNumber__c, name from Account where id IN: failureIdsSet';
        }
        else{
         Prospect = 'Prospect';
         query = 'select id, Type,SLASerialNumber__c, name from Account where Type =: Prospect';
        }
        return database.getQueryLocator(query);
    }
    //execute Method
    global void execute(database.BatchableContext bc,list<Account> scope){
     system.debug('scope--'+scope);
     //failureIdsSet = new Set<Id>();
        for(Account a:scope){
         if(a.Name =='Bangalore'){
            a.SLASerialNumber__c='tttttttttttttttttttttttttttttttttttttt';
           }
           if(a.Name =='Hyderabad'){
            a.SLASerialNumber__c='Educationyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy';
           }
        }
        
       
          Database.SaveResult[] updateResults = Database.update(scope, false);
         for(Integer i=0;i<updateResults.size();i++){
    if (updateResults.get(i).isSuccess()){

    }else if (!updateResults.get(i).isSuccess()){
        failureIdsSet.add(scope.get(i).Id);
     }

}
   
   }
   
    //finish Method  
    global void finish(database.BatchableContext bc){
        system.debug('All success Id---> ' +failureIdsSet);
        if(!failureIdsSet.isEmpty() && countTimes==0){
               countTimes++;
               database.executeBatch(new Myjobsuccess(failureIdsSet,countTimes),1);
            
        }
    }
    
}