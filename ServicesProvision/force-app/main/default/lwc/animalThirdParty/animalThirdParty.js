import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from "lightning/messageService";
import getAnimalId from '@salesforce/apex/AnimalThirdPartyController.getAnimalId';
import insertAnimal from '@salesforce/apex/AnimalThirdPartyController.insertAnimal';
import checkForDublicate from '@salesforce/apex/AnimalThirdPartyController.checkForDublicate';
import replaceValueInRecord from '@salesforce/apex/AnimalThirdPartyController.replaceValueInRecord';

export default class AnimalThirdParty extends LightningElement {
    animalInfoLabel;
    externalId;
    animalObj;
    error;
    isDublicate = false;
    fromModal = false;
    popUpWindow = false;
    modalWindow = false;
    showForm = false;

    @wire(MessageContext)
    messageContext;

    handleClick(){
        this.externalId = this.template.querySelector('lightning-input').value;
        getAnimalId({extId: this.externalId})
            .then((result) =>{
                this.animalObj = result;
                console.log(this.animalObj);
                this.error = undefined;
            })
            .catch((error) => {
                this.error = error;
                this.animalObj = undefined;
            });        
        this.animalInfoLabel = this.animalObj;

        checkForDublicate({extId: this.externalId})
            .then((result) =>{
                this.isDublicate = result;
                console.log(this.isDublicate);
            })
            .catch((error) =>{
                this.isDublicate = undefined;
            });
        this.popUpWindow = true;
    }
    callmeout(){
        console.log(this.isDublicate);
        console.log(this.animalObj);
        if(this.animalObj != 'Empty'){
            if(this.isDublicate){
                this.popUpWindow = false;
                this.modalWindow = true;
            }
            else{
                this.showForm = true;
                //publish(this.messageContext, animalObj);
            }
        }
        this.popUpWindow = false;
        }
    callmeoutModal(){
        if(this.isDublicate){
            replaceValueInRecord({extId: this.externalId});
        }
        this.modalWindow = false;
    }
    closeModal(){
        this.popUpWindow = false;
        this.modalWindow = false;
    }
    closeQuickAction(){
        this.modalWindow = false;
        this.popUpWindow = false;
    }
    closeQuickActionModal(){
        this.modalWindow = false;
        this.popUpWindow = false;
        this.showForm = true;
        //publish(this.messageContext, animalObj);
    }
    modalCloseHandler(){
        this.showForm = false;
    }
}