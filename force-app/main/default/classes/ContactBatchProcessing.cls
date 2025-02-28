global class ContactBatchProcessing implements Database.Batchable<SObject>, Schedulable {
    private List<String> contactIds;

    // Constructor to accept Contact IDs
    public ContactBatchProcessing(List<String> contactIds) {
        this.contactIds = contactIds;
    }

    // Start method for batch processing
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Get contacts updated in the last 5 minutes
        Datetime fiveMinutesAgo = System.now().addMinutes(-10);
        String query = 'SELECT Id FROM Contact WHERE LastModifiedDate >= :fiveMinutesAgo';
        return Database.getQueryLocator(query);
    }

    // Execute method to process each batch
    global void execute(Database.BatchableContext BC, List<Contact> contacts) {
        List<String> conIds = new List<String>();
        
        for (Contact c : contacts) {
            conIds.add(c.Id);
        }

        // Call GoogleSheet API only if there are contacts
        if (!conIds.isEmpty()) {
            GoogleSheetApi.appendRowsByIds(conIds);
        }
    }

    // Finish method (optional logging)
    global void finish(Database.BatchableContext BC) {
        System.debug('Batch job completed successfully.');
    }

    // Schedulable execute method to run batch job every 5 minutes
    global void execute(SchedulableContext SC) {
        Database.executeBatch(new ContactBatchProcessing(new List<String>()), 200);
    }
}