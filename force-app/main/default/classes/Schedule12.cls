public class Schedule12 implements schedulable{
    public void execute(SchedulableContext sc){
        BatchLead obj = new BatchLead();
        database.executeBatch(obj);
    }

}