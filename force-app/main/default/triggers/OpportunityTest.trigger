trigger OpportunityTest on Opportunity (After insert,after update, after delete) {
    
    if(Trigger.isafter){
        OpportunityTestHelper oph = new OpportunityTestHelper();
		oph.updateOpportunityCountInAccount(Trigger.new,Trigger.old,Trigger.newMap, Trigger.oldMap,Trigger.operationType);    
    }

}