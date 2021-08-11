import { LightningElement } from 'lwc';
import getAnimalId from '@salesforce/apex/AnimalThirdPartyController.getAnimalId';
import insertAnimal from '@salesforce/apex/AnimalThirdPartyController.insertAnimal';
import checkForDublicate from '@salesforce/apex/AnimalThirdPartyController.checkForDublicate';
import replaceValueInRecord from '@salesforce/apex/AnimalThirdPartyController.replaceValueInRecord';

export default class AnimalThirdParty extends LightningElement {
    animalInfoLabel;
    handleClick(event) {
        this.animalInfoLabel = event.target.label;
    }

    popUpWindow = false;
    handleClick(){
        this.popUpWindow = true;
    }
    closeModal(){
        this.popUpWindow = false;
    }
    closeQuickAction(){
        this.popUpWindow = false;
    }
}