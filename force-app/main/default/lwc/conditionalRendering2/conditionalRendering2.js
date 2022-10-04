import ThirdSicDesc from '@salesforce/schema/DandBCompany.ThirdSicDesc';
import { LightningElement } from 'lwc';

export default class ConditionalRendering2 extends LightningElement {
    showData = true;
    details = {
        fullName: "Balakrishna",
        place: "Hyderabad"
    };

    clickHandler() {
        this.showData = !this.showData;
    }
}