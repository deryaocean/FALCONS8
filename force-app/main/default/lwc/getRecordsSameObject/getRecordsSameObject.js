import { getRecords } from 'lightning/uiRecordApi';
import { LightningElement, track, wire } from 'lwc';

import NAME_FIELD from '@salesforce/schema/Account.Name';
import TYPE_FIELD from '@salesforce/schema/Account.Type';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';

export default class GetRecordsSameObject extends LightningElement {

    @track accounts;

    @wire(getRecords, {
        records: [
            {
                recordIds: ["0015h00000zDmMzAAK", "0015h00000zDmMwAAK"],
                fields: [NAME_FIELD, TYPE_FIELD],
                optionalFields: [INDUSTRY_FIELD]
            }
        ]
    })
    recordsHandler({data, error}) {
        if(data) {
            console.log(data);
            this.accounts = data.results;
        }
        if(error) {
            console.error(error);
        }
    }
}