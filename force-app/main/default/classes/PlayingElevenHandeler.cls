public class PlayingElevenHandeler {
    public static void Restrictions(list<Playing_Eleven__c> playingElevenList){
        try{
            set<ID> playerIdSet = new set<ID>(); 
            
            for(Playing_Eleven__c newPLay : playingElevenList ){
                if(newPLay.Player__c != null){
                    playerIdSet.add(newPLay.Player__c);
                }
            }
            list<Player__c> playerList=[SELECT Type__c,ID from Player__C WHERE id in : playerIdSet AND Type__c != null];
            Map<Id,String> playerIdVsRole = new Map<Id,String>();
            for(Player__c playerItr : playerList){
                playerIdVsRole.put(playerItr.Id,playerItr.Type__c);  
            }
            List<Playing_Eleven__c> existingPlayer = [SELECT player__r.type__c FROM playing_Eleven__C WHERE player__c != null];
            Map<String , Integer> roleVsCountMap = new Map<String , Integer>();
            for(Playing_Eleven__c itr : existingPlayer ){
                if(roleVsCountMap.containsKey(itr.player__r.type__c)){
                    roleVsCountMap.put(itr.player__r.type__c,roleVsCountMap.get(itr.player__r.type__c)+1);
                }else{
                    roleVsCountMap.put(itr.player__r.type__c,1);
                }
            }
            for(Playing_Eleven__c itr : playingElevenList){
                if(playerIdVsRole.containsKey(itr.Player__c)){
                    String role = playerIdVsRole.get(itr.Player__c);
                    Integer count = roleVsCountMap.get(role);
                    if((role == 'Batsman' && count>= 6) || (role == 'WicketKeeper' && count>= 1) || (role == 'Bowler' && count >= 3) || (role == 'All Rounder' && count>= 1)){
                        itr.addError('We can not allow more than'+role+' '+count);
                    }
                }
            }
        } 
        catch(exception ep){
            system.debug('Get line = '+ep.getLineNumber()+ 'Get cause = '+ ep.getCause() +'Message = ' +ep.getMessage());
        }
        
    }
}