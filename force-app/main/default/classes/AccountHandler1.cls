public with sharing class AccountHandler1{

    Public void onBeforeInsert(list<Account> acclist){
    
     for(Account acc:accList){
       if(acc.Name == 'Test11'){
        acc.Name = 'HelloT11177';
       }
     }
    
    }
}