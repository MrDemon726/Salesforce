public class BatchOpportunity implements Database.Batchable<sObject> , Database.stateful {
    integer recordProcessed = 0;
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([Select Id from Opportunity ]);
    }
    public void execute(Database.BatchableContext bc, List<Opportunity> opportunityList){
        List<Opportunity> oppList = new List<Opportunity>();
        for(integer i=0 ; i<5 ; i++){
            Opportunity newOpportunity = new Opportunity();
            newOpportunity.Name = 'New Opportunity';
            newOpportunity.StageName ='	Closed Won';
            newOpportunity.CloseDate = date.today();
            oppList.add(newopportunity);
        }
    }
    public void finish(Database.BatchableContext bc){
        system.debug('Opportunity Created');
    }
}