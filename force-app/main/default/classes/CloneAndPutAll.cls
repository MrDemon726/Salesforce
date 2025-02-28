public class CloneAndPutAll {
    public static void cloning(){
       // List<Account> accountList = new List<Account>();
        //accountList = [SELECT Id , Name from Account limit 5];
        //Account a = new Account(Name='Acme', BillingCity='New York');
        
        Account a = new Account(Name='Acme', BillingCity='New York');
        Account c = new Account(Name='Yash', BillingCity='France');
        Account b = new Account();
        Account[] q1 = new Account[]{a};
        system.debug(q1);
        Account[] q2 = q1.clone();
        system.debug(q1);
        system.debug(q2);
        q2.addAll(q1);
        system.debug(q2);
        Account[] q3 = new Account[]{c};
        system.debug(q3);
        q3 = q1.clone();
        system.debug(q3);
    }

}