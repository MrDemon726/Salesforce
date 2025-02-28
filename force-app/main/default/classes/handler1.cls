public class handler1 {
      public static void teamtrigger(List<Playing_Eleven__c> newList){
        Set<Id> idSet=new Set<Id>();
        for(Playing_Eleven__c play : newList){
            idSet.add(play.Player__c);
        }
        
        AggregateResult [] Agg=[Select count(Type__c)cn from Player__c where Type__c='Batsman' and id in :idSet];
        Integer bat1=(Integer)(agg[0].get('cn'));
        AggregateResult [] Agg1=[Select count(Type__c)cn1 from Player__c where Type__c='All-rounder' and id in :idSet];
        Integer bat2=(Integer)(agg1[0].get('cn1'));
        AggregateResult [] Agg2=[Select count(Type__c)cn2 from Player__c where Type__c='Bowler' and id in :idSet];
        Integer bat3=(Integer)(agg2[0].get('cn2'));
        AggregateResult [] Agg3=[Select count(Type__c)cn3 from Player__c where Type__c='Wicketkeeper' and id in :idSet];
        Integer bat4=(Integer)(agg3[0].get('cn3'));
        for(Playing_Eleven__c playing : newList){
        if(bat1>6 && bat2>1 && bat3>3 && bat4>1){
            playing.addError('Exceeded the max Limit of Player');
        }
      }
    }

}