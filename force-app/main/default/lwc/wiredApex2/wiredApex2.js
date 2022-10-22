import { LightningElement, wire } from 'lwc';
import getAccountsByIndustry from '@salesforce/apex/AccountCtrl.getAccountsByIndustry';

const COLUMNS = [
    {
        label: "Account Name", 
        fieldName: "nameUrl", 
        type: "url",
        typeAttributes: {label: {fieldName: "Name"}, target: "_blank"},
        sortable: true
    },
    {label: "Account Type", fieldName: "Type", type: "text"},
    {label: "Industry", fieldName: "Industry", type: "text"},
    {label: "Annual Revenue", fieldName: "AnnualRevenue", type: "currency"}
];

export default class WiredApex2 extends LightningElement {

    industryType = "Biotechnology";
    accounts;
    columns = COLUMNS;

    @wire(getAccountsByIndustry, {industry: '$industryType'})
    accountsHandler({data, error}) {
        if(data) {
            let nameUrl;
            this.accounts = data.map(row => {
                nameUrl = "/" + row.Id;
                return{...row, nameUrl}
            })
        }
        if(error) {
            console.error(error);
        }
    }

    get total() {
        if(this.accounts) {
            return this.accounts.length;
        } else {
            return 0;
        }        
    }
}