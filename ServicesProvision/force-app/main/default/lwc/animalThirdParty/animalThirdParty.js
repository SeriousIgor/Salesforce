import { LightningElement, wire } from 'lwc';
import getAnimalId from '@salesforce/apex/AnimalThirdPartyController.getAnimalId';
import insertAnimal from '@salesforce/apex/AnimalThirdPartyController.insertAnimal';
import checkForDublicate from '@salesforce/apex/AnimalThirdPartyController.checkForDublicate';
import replaceValueInRecord from '@salesforce/apex/AnimalThirdPartyController.replaceValueInRecord';

export default class AnimalThirdParty extends LightningElement {
    externalId = '1';
    animalObj
    animalInfoLabel;
    error;
    popUpWindow = false;
    handleClick(){
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
        insertAnimal();
        this.popUpWindow = false;
    }
    closeModal(){
        this.popUpWindow = false;
    }
    closeQuickAction(){
        this.popUpWindow = false;
    }
}