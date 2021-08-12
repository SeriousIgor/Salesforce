import { LightningElement, api, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { decodeDefaultFieldValues } from 'lightning/pageReferenceUtils';
import {
    subscribe,
    unsubscribe,
    MessageContext
  } from "lightning/messageService";

import getAnimalId from '@salesforce/apex/AnimalThirdPartyController.getAnimalId';

export default class AnimalCreate extends LightningElement {
    @wire(MessageContext)
    messageContext;

    receivedMessage;
    subscription;

    @wire(CurrentPageReference)
    setCurrentPageReference(currentPageReference) {
        // this.subscription = subscribe(
        //     this.messageContext,
        //     (message) => {
        //         this.handleMessage(message);
        //     }
        // )

        if (currentPageReference.state.defaultFieldValues) {
            const dfvObject = decodeDefaultFieldValues(currentPageReference.state.defaultFieldValues);
            this.dfv_AnimalName = dfvObject.Name;
            this.dfv_Eats = dfvObject.Eats__c;
            this.dfv_Says = dfvObject.Says__c;
            this.dfv_ExternalId = dfvObject.ExternalId__c;
            this.dfv_Flag = dfvObject.Flag__c === 'true';
        }
        //console.log(this.receivedMessage);
    }

    dfv_AnimalName = '';
    dfv_Eats = '';
    dfv_Says = '';
    dfv_ExternalId = '';
    dfv_Flag = true;

    handleMessage(message){
        this.receivedMessage = message;
    }

    // create(){
    //     this.dispatchEvent(new CustomEvent('close'));
    // }
}