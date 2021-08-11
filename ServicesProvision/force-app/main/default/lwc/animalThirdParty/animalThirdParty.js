import { LightningElement } from 'lwc';
import getAnimalId from '@salesforce/apex/AnimalThirdPartyController.getAnimalId';
import insertAnimal from '@salesforce/apex/AnimalThirdPartyController.insertAnimal';

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