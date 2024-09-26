Public class GenericClass{

 @InvocableMethod(label = 'data')
 public static void getAccountNames(list<id> id) {
 
 system.debug('value --'+id);
   
  Restcallout.RestFutureMethod(id,null);
    
}
}