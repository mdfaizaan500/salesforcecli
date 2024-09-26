public class MyQueueable1 implements Queueable, Database.AllowsCallouts {

    list < id > acclist0 = new list < id > ();
    public MyQueueable1(list<id> accl) {
        this.acclist0 = accl;
    }
    public void execute(QueueableContext context) {
        RestcalloutPOC.RestFutureMethod(acclist0);
        RestcalloutPOC.RestFutureMethodPro(acclist0);

        //System.enqueueJob(new MyQueueable2(acclist0));
    }
   
}