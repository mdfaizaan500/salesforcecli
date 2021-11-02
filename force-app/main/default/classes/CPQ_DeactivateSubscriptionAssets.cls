/*
********************************************************************************************************************************************************
Class Name     :  CPQ_DeactivateSubscriptionAssets 
Purpose        :  Batch class responsible for deactivating Subscription and its Assets.

History:                                                            
-------                                                            
VERSION  AUTHOR                 DATE            DETAIL                                                                              TICKET REFERENCE/ NO.
1.       Mohammad Faizan      1/27/2021     Created the class

*********************************************************************************************************************************************************
*/

global class CPQ_DeactivateSubscriptionAssets implements Database.Batchable<sObject> {
    
    date currentDate = system.today();
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'select id,SLAExpirationDate__c, (select id from Contacts) from Account where SLAExpirationDate__c.daysBetween(currentDate) =:2';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> subs) {
      system.debug('Print Subs-'+subs);
    }
    
    global void finish(Database.BatchableContext BC) {
        
       
           
             
    }
}