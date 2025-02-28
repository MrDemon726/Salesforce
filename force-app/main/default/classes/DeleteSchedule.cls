public class DeleteSchedule {
    public static void deleteSchedule(){
        cronJobDetail cronObj = [SELECT Id from cronJobDetail where name Like '%Schedule 1%'];
        if(cronObj !=null){
            cronTrigger cronId =[SELECT ID from cronTrigger where cronJobDetailId =:cronObj.id];
            system.abortJob(cronId.id);
        }
    }

}