Global class RestcalloutPOC {
    
     @Future(CallOut = true)
     public static void RestFutureMethod(List<Id> recordIds) {
        system.debug('recordIds--'+recordIds);
         
        HTTP hr = new HTTP();
        HTTPRequest htr = new HTTPRequest();
        htr.setHeader('Header', 'Authorization');
        htr.setMethod('GET');
        htr.setEndPoint('https://kubotaqa-developer-edition.ap4.force.com/services/apexrest/getFinancialData?accountId=');
        HTTPResponse res = hr.send(htr);
        
        if(res.getStatusCode() == 200){
         
          system.debug('test data');
          
        }
     }
     
     @Future(CallOut = true)
     public static void RestFutureMethodPro(List<Id> recordIds) {
        system.debug('recordIds--'+recordIds);
         
        HTTP hr = new HTTP();
        HTTPRequest htr = new HTTPRequest();
        htr.setHeader('Header', 'Authorization');
        htr.setMethod('GET');
        htr.setEndPoint('https://kubotaqa-developer-edition.ap4.force.com/services/apexrest/getFinancialData?accountId=');
        HTTPResponse res = hr.send(htr);
        
        if(res.getStatusCode() == 200){
         
          system.debug('test data1');
          
        }
     }

}