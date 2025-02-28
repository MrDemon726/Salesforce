public class BatchAccountUpdate implements 
Database.Batchable<sObject> , Database.stateful{
    Integer recordProcessed = 0;
    public Database.QueryLocator start (Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id from Account]);
    }
    public void execute(Database.BatchableContext bc, List<Account> scope){
        List<Account> accountList = [SELECT id, (SELECT id from contacts) from  Account where id in : scope];
        // List<Account> accList = new List<Account>();
        if(accountList != null){
            system.debug(accountList);
            For(Account acc : accountList){
                integer count = acc.contacts.size();
                acc.Contact_Count__c = count;
            }
            update accountList;
        }
    }
    public void finish (DataBase.BatchableContext bc){
        System.debug('Account Updated');
    }
}