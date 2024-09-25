public class OpportunityTestHelper {
    
    public  void updateOpportunityCountInAccount(List<Opportunity> oppListNw, List<Opportunity> oppListOld, Map<id,Opportunity> oppMapNw, Map<id,Opportunity> oppMapOld, System.TriggerOperation operation){
        List<Id> accsIds = new List<Id>();
        if(operation == System.TriggerOperation.BEFORE_INSERT){
            for(Opportunity opp : oppListNw){
                if(opp.accountId != null){
                    accsIds.add(opp.accountId);
                }
            }
            countOpprtunities(accsIds);    
        }
        if(operation == System.TriggerOperation.BEFORE_UPDATE){
            for(Opportunity opp : oppListNw){
                if(opp.accountId != oppMapOld.get(opp.Id).accountId){
                    accsIds.add(opp.accountId);
                }
            }
            countOpprtunities(accsIds);    
        }
    
    }
    
    public void countOpprtunities(List<id> acctsIds){
                List<AggregateResult> aggRes = new  List<AggregateResult>();
        Account acc;
        List<Account> accsToUpdate = new List<Account>();
        aggRes = [SELECT count(id) opp, accountId FROM Opportunity WHERE accountId IN :acctsIds GROUP BY accountId];
        for(AggregateResult agr : aggRes){
			acc = new Account();
            acc.id = (Id)agr.get('accountId');
            acc.NumberOfEmployees =(Integer)agr.get('opp');
            accsToUpdate.add(acc);
        }
        if(accsToUpdate.size() > 0){
            update accsToUpdate;
        }
    }

}