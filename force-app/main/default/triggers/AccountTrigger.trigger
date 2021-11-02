trigger AccountTrigger on Account (Before insert) {
    
  {
    AccountHandler1 acc = new AccountHandler1();
    
    if(trigger.isInsert && trigger.isBefore){
     acc.onBeforeInsert(Trigger.New);
    }
}
}