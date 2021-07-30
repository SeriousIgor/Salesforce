trigger AnimalFilling on Animal__c (after insert) {
	
    List<Animal__c> animalToUpdateList = new List<Animal__c>();
    
    for(Animal__c animal: (List<Animal__c>)Trigger.new){
        if(!animal.flag__c){
            animalToUpdateList.add(animal);
        }
    }
    Animal someAnimal = new Animal(animalToUpdateList);
    
    System.enqueueJob(someAnimal);
}