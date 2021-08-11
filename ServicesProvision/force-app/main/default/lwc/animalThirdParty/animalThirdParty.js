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
    isDublicate = false;
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

        checkForDublicate({extId: this.externalId})
            .then((result) =>{
                this.isDublicate = result;
                console.log(this.isDublicate);
            })
            .catch((error) =>{
                this.isDublicate = undefined;
            });
        
        if(this.isDublicate){
            this.modalWindolLabel = 'There are one or more records in DB with same External ID. Would you like to update them instead of insert new record?'
        }
        
        this.popUpWindow = true;
    }
    callmeout(){
        if(this.isDublicate){
            replaceValueInRecord({extId: this.externalId});
        }
        else{
            insertAnimal({extId: this.externalId});
        }
        
        this.popUpWindow = false;
    }
    closeModal(){
        if(this.isDublicate){
            insertAnimal({extId: this.externalId});
        }

        this.popUpWindow = false;
    }
    closeQuickAction(){
        if(this.isDublicate){
            insertAnimal({extId: this.externalId});
        }

        this.popUpWindow = false;
    }
}