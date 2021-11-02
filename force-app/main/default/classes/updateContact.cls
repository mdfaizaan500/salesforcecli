global class updateContact implements Database.Batchable<sobject>{

 list<Contact> abb = new list<Contact>();
 global Database.QueryLocator start(Database.BatchableContext bc){
  string query = 'Select id, Name from Contact limit 1';
  return Database.getQueryLocator(query);
 }

 global void execute(Database.BatchableContext bc, list<Contact> contlist){
   for(Contact ct : contList){
      ct.Phone= '6757567677';     
    abb.add(ct);
   }
   update abb;
 }
global void finish(Database.BatchableContext bc){
 
 }
}