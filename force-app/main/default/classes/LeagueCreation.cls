public class LeagueCreation {
    public static void newTeam(){
        List<Team__c> newTeamList = new List<Team__c>();
        for(Integer i=1; i<=8; i++){
            Team__c newTeam = new Team__c();
            if(i<3){
                newTeam.name = 'Team'+i;
                newTeam.Region__c = 'East';
                newTeam.Capital__c = 150;
            }
            if(i>=3 && i<=4){
                newTeam.name = 'Team'+i;
                newTeam.Region__c = 'West';
                newTeam.Capital__c = 150;
            }
            if(i>=5 && i<=6){
                newTeam.name = 'Team'+i;
                newTeam.Region__c = 'North';
                newTeam.Capital__c = 150;
            }
            if(i>=7 && i<=8){
                newTeam.name = 'Team'+i;
                newTeam.Region__c = 'North';
                newTeam.Capital__c = 150;
            }
            newTeamList.add(newTeam);
        }
        insert newTeamList;
        system.debug('Teams :- ' + newTeamList);
    }
    public static void createPlayer(){
        List<Player__c> newPlayerList = new List<Player__c>();
        for(Integer i = 1; i<100; i++){
            Player__c newPlayer = new Player__c();
            if(i<=10){
                newPlayer.Name = 'Player'+i;
                newPlayer.City__c = 'City'+i;
                newPlayer.Base__c = '20';
                newPlayer.Type__c = 'Batsman';
            }
            if(i>=11 && i<=20){
                newPlayer.Name = 'Player'+i;
                newPlayer.City__c = 'City'+i;
                newPlayer.Base__c = '15';
                newPlayer.Type__c = 'Batsman';
            }
            if(i>=21 && i<=30){
                newPlayer.Name = 'Player'+i;
                newPlayer.City__c = 'City'+i;
                newPlayer.Base__c = '10';
                newPlayer.Type__c = 'Batsman';
            }
            if(i>=31 && i<=40){
                newPlayer.Name = 'Player'+i;
                newPlayer.City__c = 'City'+i;
                newPlayer.Base__c = '5';
                newPlayer.Type__c = 'Batsman';
            }
        }
    }
}