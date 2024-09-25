public with sharing class DTA_InvoiceGeneratonForRent {
    @AuraEnabled(cacheable=true)  
    Public Static List<ContractWrapper>  fetchContractsList(Id accountId, String objectName){  
        List<Contract> contracts = new List<Contract>();
        List<ContractWrapper> contractsWrapped = new List<ContractWrapper>();
        if(objectName == 'Account' ){
            contracts =[SELECT Status, Opportunity__r.Name, Account.Name, DTA_Fixed_Income__c
            FROM Contract WHERE AccountId = : accountId  WITH SECURITY_ENFORCED];
            //comment 
        }else{

            contracts =[SELECT Status, Opportunity__r.Name, Account.Name, DTA_Fixed_Income__c
            FROM Contract  WITH SECURITY_ENFORCED];
        }
           
        System.debug('Fetch Contracts for '+accountId); 
        System.debug('Fetch Object for '+objectName); 
        System.debug(contracts);
        for(Contract c:contracts ){
            ContractWrapper cw = new ContractWrapper();
            System.debug('Contracts []' +c); 
            System.debug('Account NAme = '+c.Account.Name);
        
            cw.contractId = c.Id;
            cw.accountName =c.Account.Name;
            cw.opportunityName = c.Opportunity__r.Name;
            cw.status = c.Status;
            cw.fixedIncome = c.DTA_Fixed_Income__c;
            contractsWrapped.add(cw);
        }
        System.debug(contractsWrapped);
        return contractsWrapped;  
   }  
   Public class ContractWrapper {
        @AuraEnabled public Id contractId {get;set;}
        @AuraEnabled public String accountName {get;set;}
        @AuraEnabled public String opportunityName {get;set;}
        @AuraEnabled public String status {get;set;}
        @AuraEnabled public Decimal fixedIncome {get;set;}

        public ContractWrapper(){
           //test
           System.debug('test');
        } 
   }
    @AuraEnabled  
    public static void generateInvoicesForContracts(List<ContractWrapper> contractList){  
        System.debug(contractList);
        List<ID> contractsIds = new List<ID>(); 
        for(ContractWrapper cw : contractList ){
            contractsIds.add(cw.contractId);
        }
        System.debug(contractsIds);
   }  
}