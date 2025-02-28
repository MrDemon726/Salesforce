public class Schedule2 implements schedulable {
    public void execute (schedulableContext sc){
        BatchDeleteAccount obj = new BatchDeleteAccount();
        database.executeBatch(obj);
    }
    
}