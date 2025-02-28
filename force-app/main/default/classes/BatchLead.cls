public class BatchLead implements Database.Batchable<sObject> , Database.stateful{
  public Database.QueryLocator start (Database.BatchableContext bc){
    date d = date.today().addDays(-1);
    return Database.getQueryLocator([Select id,Name,Title,Company from Lead where CreatedDate = : d and Phone =null]);
  }
  public void execute(Database.BatchableContext bc, List<Lead> leadList){
    User newUser = new User();
    newUser =[SELECT Email from User where Profile.Name = 'System Administrator'];
    for(Lead leadItr : leadList){
      EmailManager.sendMail(newUser.Email , 'Lead Details',string.valueof(leadItr));
    }
  }
  public void finish(Database.BatchableContext bc){
    system.System.debug('Mail Sent');
  }

}