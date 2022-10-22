import { LightningElement, wire } from 'lwc';

import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import TITLE_FIELD from '@salesforce/schema/Contact.Title';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import MOBILE_FIELD from '@salesforce/schema/Contact.MobilePhone';
import DEPT_FIELD from '@salesforce/schema/Contact.Department';
import { getFieldValue, getRecord } from 'lightning/uiRecordApi';

const FIELDS = [FIRSTNAME_FIELD, LASTNAME_FIELD, TITLE_FIELD, EMAIL_FIELD, MOBILE_FIELD, DEPT_FIELD];

export default class GetRecordContact extends LightningElement {

    recordId = "0035h00000kjlmSAAQ";
    contact;

    @wire(getRecord, {recordId: '$recordId', fields: FIELDS})
    recordHandler({data, error}) {
        if(data) {
            this.contact = data;
        }
        if(error) {
            console.error(error);
        }
    }

    get name() {
        return getFieldValue(this.contact, FIRSTNAME_FIELD) + " " + getFieldValue(this.contact, LASTNAME_FIELD);
    }

    get title() {
        return getFieldValue(this.contact, TITLE_FIELD);
    }

    get email() {
        return getFieldValue(this.contact, EMAIL_FIELD);
    }

    get mobile() {
        return getFieldValue(this.contact, MOBILE_FIELD);
    }

    get department() {
        return getFieldValue(this.contact, DEPT_FIELD);
    }
}