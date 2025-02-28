public class ScheduleBatch9 implements schedulable{
    public void execute (schedulableContext sc){
        BatchAccountUpdate obj = new BatchAccountUpdate();
        database.executeBatch(obj);
    }

}