trigger Playing_Eleven_trigger on Playing_Eleven__c (before insert, before update ) {
    if(trigger.isBefore){
    if(trigger.isUpdate || trigger.isInsert){
       PlayingElevenHandeler.Restrictions(trigger.new);
    }
    }

}