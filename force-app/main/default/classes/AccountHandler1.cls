public with sharing class AccountHandler1{

    Public void onBeforeInsert(list<Account> acclist){
    
     for(Account acc:accList){
       if(acc.Name == 'Test1'){
        acc.Name = 'HelloT1155';
       }
     }
    
    }
}