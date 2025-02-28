public class BatchDeleteAccount implements
Database.Batchable<sObject>, Database.Stateful {
    integer recordProcessed = 0;
    public Database.QueryLocator start (Database.BatchableContext bc){
          date d=system.today().adddays(-10);        
        return Database.getQueryLocator([Select id from Account where createdDate < : d limit 10]);
    }
    public void execute (Database.BatchableContext bc , List<Account> accountList){
       delete accountList;
    }
    public void finish (Database.BatchableContext bc){
        system.debug('Accounts Deleted');
    }
}