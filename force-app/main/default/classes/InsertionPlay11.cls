public class InsertionPlay11 {
    public static void insertion(){
        list<Playing_Eleven__c> elementList = new list<Playing_Eleven__c>();
        list<PLayer__c> allPLayers = new list <Player__c>();
        list<PLayer__c> batsManList=[select ID, Name from PLayer__c where Player__c.Type__c ='Batsman' limit 6  ];
        list<PLayer__c> bowlerList=[select ID, Name from PLayer__c where Player__c.Type__c ='Bowler' limit 3  ];
        list<PLayer__c> allRounderList=[select ID, Name from PLayer__c where Player__c.Type__c ='All Rounder' limit 1 ];
        list<PLayer__c> wicketKeeperList=[select ID, Name from PLayer__c where Player__c.Type__c ='WicketKeeper' limit 1  ];
        allPLayers.addAll(batsManList);
        allPLayers.addAll(bowlerList);
        allPLayers.addAll(allRounderList);
        allPLayers.addAll(wicketKeeperList);
        system.debug(allPLayers);
        for(Player__c addPlayer : allPlayers){
            
                Playing_Eleven__c newPlayingEleven = new Playing_Eleven__c();
                newPlayingEleven.Name = 'Test_PlayingEleven';
            	newPlayingEleven.Player__c =addPlayer.Id;
            	elementList.add(newPlayingEleven);
        }
        insert elementList;
        system.debug(elementList);
    
    }
}