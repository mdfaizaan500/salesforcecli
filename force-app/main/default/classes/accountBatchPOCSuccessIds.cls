global class accountBatchPOCSuccessIds implements database.Batchable<sObject>,Database.Stateful {
    
    global Map<Id,String> failedRecordIdMap = new Map<Id,String>();
    global Integer retryCount = 1;
    global Set<Id> failedIds = new Set<Id>();
    
    public accountBatchPOCSuccessIds(){
      
    }
    
    public accountBatchPOCSuccessIds(Map<Id,String> failedIds,Integer retryCount){
        this.failedIds = failedIds.keyset();
        this.retryCount = retryCount+1;
    }
  
    
    public database.QueryLocator start(database.BatchableContext bc){
    string query;
    string Prospect ='Prospect';
        if(failedIds !=null && !failedIds.isEmpty()){
         query = 'select id, Type,SLASerialNumber__c, name from Account where id IN: failedIds';
        }
        else{
         query = 'select id, Type,SLASerialNumber__c, name from Account where Type =: Prospect';
        }
        return database.getQueryLocator(query);
    }
    //execute Method
    public void execute(database.BatchableContext bc,list<Account> scope){
        for(Account a:scope){
            a.SLASerialNumber__c='tttttttttttttttttttttttttttttttttttttt';
        }   
        if(scope.size()>0){
            failedRecordIdMap.putAll(SystemLogUtils.updateMultipleObjsAndRetry(scope, false));    
        }
    }
   
    //finish Method  
    public void finish(database.BatchableContext bc){
      if(!failedRecordIdMap.isEmpty() && failedRecordIdMap !=null){
         Map<String,Integer> retryTimes = SystemLogUtils.batchRetryMethod(failedRecordIdMap,retryCount,'accountBatchPOCSuccessIds');
         if(retryTimes !=null){
         DataBase.executeBatch(new accountBatchPOCSuccessIds(failedRecordIdMap,retryTimes.get(SystemLogConstantUtility.RETRY_COUNT)),retryTimes.get(SystemLogConstantUtility.BATCH_SIZE));
         }
      }
    }
    
}