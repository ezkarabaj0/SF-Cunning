trigger AccountTest on Account (After insert, After Update ) {

    if(Trigger.isUpdate){
        if(Trigger.isAfter){
            AccountTestTriggerHelper.updateContacts(Trigger.new,Trigger.old, Trigger.newMap,  Trigger.oldmap );
        }
    }
}