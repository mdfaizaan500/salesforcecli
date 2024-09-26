trigger SubscribeTrigger on BatchApexErrorEvent (after insert) {
    Set<Id> asyncApexJobIds = new Set<Id>();
    for(BatchApexErrorEvent evt:Trigger.new){
        asyncApexJobIds.add(evt.AsyncApexJobId);
    }
    
    Map<Id,AsyncApexJob> jobs = new Map<Id,AsyncApexJob>(
        [SELECT id, ApexClass.Name FROM AsyncApexJob WHERE Id IN :asyncApexJobIds]
    );
    
    List<Exception_Logger__c> records = new List<Exception_Logger__c>();
    for(BatchApexErrorEvent evt:Trigger.new){
        //only handle events for the job(s) we care about
        if(jobs.get(evt.AsyncApexJobId).ApexClass.Name == 'accountBatchPOC'){
                Exception_Logger__c a = new Exception_Logger__c();
                a.Exception_Type__c = evt.ExceptionType;
                a.JobScope__c = evt.JobScope;
                a.Message__c = evt.Message;
                a.Phase__c = evt.Phase;   
                a.AsyncApexJobId__c = evt.AsyncApexJobId;
                a.RequestId__c = evt.RequestId;       
                records.add(a);           
        }
    }
    insert records;
}