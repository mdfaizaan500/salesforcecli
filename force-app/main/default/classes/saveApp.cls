public inherited sharing class saveApp{

@AuraEnabled
public static void getAppDetail(string appDetail) {
system.debug('twsthhj'+appDetail);

    if(appDetail !=Null){
    
        List<String> listValues = appDetail.split(',');
        
        system.debug('appDetail-'+listValues);
        system.debug('appDetail-'+listValues[0]);
        system.debug('appDetail-'+listValues[1]);
        Application__c app = new Application__c();
        if(listValues[0] != 'undefined'){app.FirstName__c=listValues[0];}
        
        if(listValues[1] != 'undefined'){app.MiddleName__c =listValues[1];}
        
        if(listValues[2] != 'undefined'){app.LastName__c =listValues[2];}
       
        if(listValues[3] != 'undefined'){app.Contact_Number__c =listValues[3];}
        
        if(listValues[4] != 'undefined'){app.Address_Line_1__c =listValues[4];}
        
        if(listValues[5] != 'undefined'){app.Address_Line_2__c =listValues[5];}
        
        if(listValues[6] != 'undefined'){app.Previous_Exam_Detail__c =listValues[6];}
        
        if(listValues[7] != 'undefined'){app.Result__c =listValues[7];}
        
        if(listValues[8] != 'undefined'){app.Percentage__c = listValues[8];}
        
        if(listValues[9] != 'undefined'){app.Course__c=listValues[9];}
       
        if(listValues[10] != 'undefined'){app.Year__c= listValues[10];}
        
        if(listValues[11] != 'undefined'){app.Additional_Detail__c=listValues[11];}
        
        if(listValues[12] != 'undefined'){app.Blood_Group__c =listValues[12];}
        
        insert app;
}
}
}