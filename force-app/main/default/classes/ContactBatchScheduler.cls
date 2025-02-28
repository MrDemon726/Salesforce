global class ContactBatchScheduler implements Schedulable {
    global void execute(SchedulableContext SC) {
        Database.executeBatch(new ContactBatchProcessing(new List<String>()), 200);
    }
}