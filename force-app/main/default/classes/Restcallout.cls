Global class Restcallout {
    
     @Future(CallOut = true)
     public static void RestFutureMethod(List<Id> recordIds,map<String,String> mapRetryCount) {
      
        List<Id> accountId = recordIds;
        //string actid =(String)accountId[0];
        string payload = (String)accountId[0];
        HTTP hr = new HTTP();
        HTTPRequest htr = new HTTPRequest();
        htr.setHeader('Header', 'Authorization');
        htr.setMethod('GET');
       // ht.setBody(payload);
        htr.setEndPoint('https://kubotaqa-developer-edition.ap4.force.com/services/apexrest/getFincialData?accountId='+payload);
        HTTPResponse res = hr.send(htr);
        
        if(res.getStatusCode() == 200){
         
          fromJSON tt =   (fromJSON)System.JSON.deserialize(res.getBody(),fromJSON.class);
          system.debug('test data -'+ tt.revenue);
          
          Account act =[select id, Revenue__c,Financial_Code__c,Is_Affiliated__c from Account where id =: recordIds];
          act.Revenue__c = tt.revenue;
          act.Financial_Code__c = tt.financialCode;
          act.Is_Affiliated__c =tt.isAffiliated;
          act.Financial_Data_Populated__c = true;
          update act;
        
        }else{
           if(mapRetryCount == null || mapRetryCount.isEmpty()){
              // SystemLogUtils.insertSystemLogs(payload,res.getBody());
           }
           else if(mapRetryCount !=null && mapRetryCount.get('retryCount') <= mapRetryCount.get('maxRetry')){
              Integer inrementRetry = integer.valueOf(mapRetryCount.get('retryCount')); 
            //  inrementRetry++;
              string retryCount = string.ValueOf(inrementRetry++);
              mapRetryCount.put('retryCount',retryCount);
              Restcallout.RestFutureMethodRetry(recordIds,mapRetryCount);            
           }
           else{
               System_Log__c systemLog = new System_Log__c();
               systemLog.Id = Id.valueOf(mapRetryCount.get('logRecord'));
               //systemLog.Retry__c = false;
               //systemLog.Payload__c = payload;
               //systemLog.Status__c = 'Exceeded Retry Count';
           }      
        }
            
        system.debug('value response'+res.getBody());
        
    }
    
    public static void RestFutureMethodRetry(List<Id> recordIds,map<String,String> mapRetryCount) {
    
    Restcallout.RestFutureMethod(recordIds,mapRetryCount); 
    }
    
    public class fromJSON{
    public Integer revenue; 
    public boolean isAffiliated;
    public string financialCode;
    
    }

}