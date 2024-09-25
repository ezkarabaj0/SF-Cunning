import { LightningElement,wire,track,api } from 'lwc';
import {refreshApex} from '@salesforce/apex';
import getContracts from '@salesforce/apex/DTA_InvoiceGeneratonForRent.fetchContractsList'
import generateInvoces from '@salesforce/apex/DTA_InvoiceGeneratonForRent.generateInvoicesForContracts';
const COLUMNS=[
    {label:'Account',fieldName:'accountName', type:'text'},
    {label:'Opportunity',fieldName:'opportunityName', type:'text'},
    {label:'Status',fieldName:'status', type:'text'},
    {label:'Monto',fieldName:'fixedIncome', type:'text'}]
export default class ContractsForInvoice extends LightningElement {
    @api recordId;
    @api objectApiName;
    
    cols =COLUMNS;
    @wire(getContracts, {accountId: '$recordId', objectName: '$objectApiName' } ) contractsList;
    generate(){  
        alert(this.objectApiName);
        var selectedRecords =  
         this.template.querySelector("lightning-datatable").getSelectedRows();  
        
         generateInvoces({contractList: selectedRecords})  
        .then(result=>{  
            alert('Las Facturas Seleccionadas Fueron Generadas :');    
            return refreshApex(this.contractsList);  
          
        })  
        .catch(error=>{  
          alert('Cloud not delete'+JSON.stringify(error));  
        })  
      }
   
}