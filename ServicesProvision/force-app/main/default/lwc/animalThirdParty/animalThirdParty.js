import { LightningElement, wire } from 'lwc';
import getAnimalId from '@salesforce/apex/AnimalThirdPartyController.getAnimalId';
import insertAnimal from '@salesforce/apex/AnimalThirdPartyController.insertAnimal';
import checkForDublicate from '@salesforce/apex/AnimalThirdPartyController.checkForDublicate';
import replaceValueInRecord from '@salesforce/apex/AnimalThirdPartyController.replaceValueInRecord';

export default class AnimalThirdParty extends LightningElement {
    modalWindolLabel;
    animalInfoLabel;
    externalId;
    animalObj;
    error;
    updateRecord = false;
    popUpWindow = false;

    handleClick(){
        this.modalWindolLabel = 'Are you sure you would like to Insert record to database?';
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
        this.popUpWindow = true;
    }
    callmeout(){
        if(!this.updateRecord){
            insertAnimal({extId: this.externalId});
        }
        else{
            replaceValueInRecord({extId: this.externalId});
        }
        this.popUpWindow = false;
    }
    closeModal(){
        this.popUpWindow = false;
    }
    closeQuickAction(){
        this.popUpWindow = false;
    }
}