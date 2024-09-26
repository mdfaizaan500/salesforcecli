global class scheduleAccount implements schedulable
{
    global void execute(SchedulableContext sc)
    {
    accountupdate b = new accountupdate(); //ur batch class
    database.executebatch(b);
    }
}