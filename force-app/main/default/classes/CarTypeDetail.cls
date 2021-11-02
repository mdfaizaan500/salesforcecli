Public class CarTypeDetail
{

    @AuraEnabled
    Public static list<CarType__c> Cartypesavailable(){
    
    return [select id,name from CarType__c];
    
    }
    
    @AuraEnabled
    Public static List<AuthorizationFieldAccess> CountryType(string userid){
        // User lstUser = [Select ContactId from User where Id = :userid];
        // Contact contdata= [select Account.Country__c, CountryValue__c from contact where id =:lstUser.ContactId];
        Contact contdata = [select Account.Country__c, CountryValue__c from contact where id =: userid];
        List<AuthorizationFieldAccess> authAccessList = new List<AuthorizationFieldAccess>();
        system.debug('Name : ' + contdata);
        Authorization__c auth = Authorization__c.getValues(contdata.Account.Country__c);
        system.debug('auth : ' + auth);
        Map <String, Schema.SObjectField> fieldMap = Schema.getGlobalDescribe().get('Authorization__c').getDescribe().fields.getMap();
        system.debug('fieldMap : ' + fieldMap);
        for(Schema.SObjectField sfield : fieldMap.values())
        {
        String str = sfield.getDescribe().getName();
        system.debug('str ---'+str);
        if(str.endsWithIgnoreCase('__c') && sfield.getDescribe().getType()==Schema.DisplayType.BOOLEAN) {
        system.debug('1----------'+Schema.DisplayType.BOOLEAN);
        system.debug('2----------'+sfield.getDescribe().getType());
            if(auth.get(sfield.getDescribe().getName())==true) {
                AuthorizationFieldAccess authAccess = new AuthorizationFieldAccess(); 
                authAccess.name = sfield.getDescribe().getLabel();
                if(contdata.CountryValue__c.contains(sfield.getDescribe().getLabel())) {
                    authAccess.access = true;
                } else {
                    authAccess.access = false;
                }
                authAccessList.add(authAccess);
            }
          
            }
        System.debug('authAccessList : '+authAccessList);    
        System.debug('authAccessList size : '+authAccessList.size());
        }
        return authAccessList;
        
      }
      
    public class AuthorizationFieldAccess {
        @AuraEnabled
        public String name{get;set;}
        @AuraEnabled
        public Boolean access{get;set;}
    }
    
             
}