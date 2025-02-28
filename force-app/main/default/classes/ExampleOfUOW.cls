public with sharing class ExampleOfUOW {
    public void objectCreator() {
        fflib_ISObjectUnitOfWork unitOfWork = FFLIBCustomApplication.UNITOFWORK.newInstance();
        List<Account> newAccount = new List<Account>{new Account(Name = 'Val')};
        unitOfWork.registerNew(newAccount);
        List<Contact> newContact = new List<Contact>{new Contact(LastName ='Predator', FirstName ='Apex')};
        unitOfWork.registerNew(newContact);
        unitOfWork.registerRelationship(newContact[0], Contact.AccountId, newAccount[0]);
        try{
            unitOfWork.commitWork();
            System.debug('These are the new contacts linked with account ==>' + newContact[0].Id);
        }

        catch(Exception  ex){
            throw ex;
        }
    }
}