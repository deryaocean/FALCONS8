import { LightningElement } from 'lwc';

export default class MyDetails extends LightningElement {
    name;
    role;

    nameChangeHandler(event) {
        this.name = event.target.value;
    }

    roleChangeHandler(event) {
        this.role = event.target.value;
    }

    get roleOptions() {
        return [
            {label: "Salesforce Admin", value: "Salesforce Admin"},
            {label: "Salesforce Developer", value: "Salesforce Developer"},
            {label: "Salesforce Architect", value: "Salesforce Architect"}
        ];
    }
}