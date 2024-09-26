trigger SystemLogTrigger on System_Log__c (after insert) {
    /*map<String,String> mapRetryCount = new map<String,String>();
    Logging_Level__c cs = Logging_Level__c.getInstance('00e0o0000024ZGG');
    Integer maxRetry = integer.valueOf(cs.Integration_Retry_Count__c);
    for(System_Log__c slog:trigger.new){
      if(slog.Retry__c){
          List<Id> recordId = new List<Id>();
          recordId.add(Id.valueOf(slog.Payload__c));
          mapRetryCount.put('retryCount','1');
          mapRetryCount.put('maxRetry',string.valueOf(maxRetry));
          mapRetryCount.put('logRecord',string.valueOf(slog.Id));   
          Restcallout.RestFutureMethod(recordId,mapRetryCount);                       
      }   
    }*/
}