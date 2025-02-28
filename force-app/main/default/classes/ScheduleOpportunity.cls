public class ScheduleOpportunity implements schedulable {
     public void execute (schedulableContext sc){
        BatchOpportunity obj = new BatchOpportunity();
        database.executeBatch(obj);
    }

}