import { LightningElement } from 'lwc';

import LEAD_OBJECT from '@salesforce/schema/Lead';
import { createRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Leadform extends LightningElement {
    formdata = {};

    changeHandler(event) {
        const {name, value} = event.target;
        this.formdata[name] = value;
    }

    saveLead() {
        const recordInput = {
            apiName: LEAD_OBJECT.objectApiName,
            fields: this.formdata
        };

        createRecord(recordInput)
            .then(result => {
                console.log(result);
                this.template.querySelector('form.leadform').reset();
                const successToast = new ShowToastEvent({
                    title: "Sucess",
                    message: "Lead has been saved!",
                    variant: "success"
                });
                this.dispatchEvent(successToast);
            })
            .catch(error => {
                console.error(error);
            })
    }
}