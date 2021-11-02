public class MyQueueable2 implements Queueable, Database.AllowsCallouts {
        List<id> accList = new List<id>();
        public MyQueueable2(List<id> accList1) {
            this.accList=accList1;
        }
        public void execute(QueueableContext context) {
            RestcalloutPOC.RestFutureMethod(accList);
        }
    }