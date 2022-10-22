import { getObjectInfo, getPicklistValuesByRecordType } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';

import OPP_OBJECT from '@salesforce/schema/Opportunity';

export default class OpportunityForm extends LightningElement {

    oppRtId;
    typeOptions = [];
    selectedType;
    stageOptions = [];
    selectedStage;
    oppName;

    @wire(getObjectInfo, {objectApiName: OPP_OBJECT})
    objectInfoHandler({data, error}) {
        if(data) {
            console.log(data);
            this.oppRtId = data.defaultRecordTypeId;
        }
        if(error) {
            console.error(error);
        }
    }

    @wire(getPicklistValuesByRecordType, {objectApiName: OPP_OBJECT, recordTypeId: '$oppRtId'})
    picklistHandler({data, error}) {
        if(data) {
            console.log(data);
            this.typeOptions = data.picklistFieldValues.Type.values;
            this.stageOptions = data.picklistFieldValues.StageName.values;
        }
        if(error) {
            console.error(error);
        }
    }

    changeHandler(event) {
        if(event.target.label === "Opportunity Name") {
            this.oppName = event.target.value;
        } else if(event.target.label === "Opportunity Stage") {
            this.selectedStage = event.target.value;
        } else {
            this.selectedType = event.target.value;
        }
    }
}