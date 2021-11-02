global class SystemLogTruncationBatch implements database.Batchable<sObject>,Database.Stateful {
    global DateTime startDate;
    global DateTime endDate;
    global List<String> logLevelList;
    global Integer recordCount=0;
    public SystemLogTruncationBatch(DateTime startDate,DateTime endDate,List<String> logLevelList){
        this.startDate = startDate;
        this.endDate = endDate;
        this.logLevelList = logLevelList;
    }    
        
    public database.QueryLocator start(database.BatchableContext bc){
        string query;
        query = 'SELECT Id,CreatedDate,Log_Level__c FROM System_Log__c WHERE Log_Level__c IN: logLevelList AND CreatedDate >=: startDate AND CreatedDate <=: endDate';
        return database.getQueryLocator(query);
    }
    
    //execute Method
    public void execute(database.BatchableContext bc,list<System_Log__c> scope){
        if(scope.size()>0){
            SystemLogUtils.deleteMultipleObjsAndRetry(scope, false);
            recordCount+= scope.size();   
        }
    }
   
    //finish Method  
    public void finish(database.BatchableContext bc){
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id =:bc.getJobId()];
        Delete_Log__c deleteLogRec = new Delete_Log__c(Apex_Job_Id__c= a.Id,Records_Processed__c=recordCount,Start_Date__c=startDate,End_Date__c=endDate,Log_Level__c=string.join(logLevelList,','));
        insert deleteLogRec;
    }
}