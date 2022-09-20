import { getRecords } from 'lightning/uiRecordApi';
import { LightningElement, wire } from 'lwc';

import ACC_NAME_FIELD from '@salesforce/schema/Account.Name';
import ACC_TYPE_FIELD from '@salesforce/schema/Account.Type';
import ACC_INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import CON_NAME_FIELD from '@salesforce/schema/Contact.Name';
import CON_TITLE_FIELD from '@salesforce/schema/Contact.Title';

export default class GetRecordsMultipleObjects extends LightningElement {

    @wire(getRecords, {
        records: [
            {
                recordIds: ["0015h00000zDmMwAAK"],
                fields: [ACC_NAME_FIELD, ACC_TYPE_FIELD],
                optionalFields: [ACC_INDUSTRY_FIELD]
            },
            {
                recordIds: ["0035h00000kJTr8AAG", "0035h00000kjlmSAAQ"],
                fields: [CON_NAME_FIELD],
                optionalFields: [CON_TITLE_FIELD]
            }
        ]
    })
    recordsHandler({data, error}) {
        if(data) {
            console.log(data);
        }
        if(error) {
            console.error(error);
        }
    }
}