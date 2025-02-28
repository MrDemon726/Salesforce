public class Creation {
    public static void createTeam(){
        try{
       list<Team__c> teamList=new list<Team__c>();
         for(integer i=0;i<2;i++){
             Team__c newTeam= new Team__C();
             newTeam.Name='Team'+i;
             newTeam.Country__c='Country'+i; 
             teamList.add(newTeam);
             }
        insert teamList;
            system.debug(teamList);
        }
        catch(exception ep){
            system.debug('Get line = '+ep.getLineNumber()+ 'Get cause = '+ ep.getCause() +'Message = ' +ep.getMessage());
        }
        }
      public static void creatingPlayers(){
          try{
          list<Player__c> playerList= new list<Player__c>();
          for(integer i=1;i<=14;i++){
              Player__c newPlayer= new Player__c();
              if(i==1){
                  newPlayer.Name='Player'+i;
                  newPlayer.Jersey_Number__c=i;
                  newPlayer.Type__c='WicketKeeper';
                  playerList.add(newPlayer);
              }
              if(i==2){
                  newPlayer.Name='Player'+i;
                  newPlayer.Jersey_Number__c=i;
                  newPlayer.Type__c='All Rounder';
                  playerList.add(newPlayer);
              }
              if(i>=3 && i<=5){
                  newPlayer.Name='Player'+i;
                  newPlayer.Jersey_Number__c=i;
                  newPlayer.Type__c='Bowler';
                  playerList.add(newPlayer);
              }
              if(i>=6 && i<=11){
                  newPlayer.Name='Player'+i;
                  newPlayer.Jersey_Number__c=i;
                  newPlayer.Type__c='Batsman';
                  playerList.add(newPlayer);
              }
              if(i>=12 && i<=14){
                  newPlayer.Name='Player'+i;
                  newPlayer.Jersey_Number__c=i;
                  newPlayer.Type__c='!2thMan';
                  playerList.add(newPlayer);
              }
          }
              insert playerList;
              system.debug(playerList);
          }
          catch(exception ep){
              system.debug('Get line = '+ep.getLineNumber()+ 'Get cause = '+ ep.getCause() +'Message = ' +ep.getMessage());
          }
          
      }
 }