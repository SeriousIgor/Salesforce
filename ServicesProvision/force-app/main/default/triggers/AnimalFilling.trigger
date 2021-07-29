trigger AnimalFilling on Animal__c (after insert) {
	Animal someAnimal = new Animal(Trigger.new);
    System.enqueueJob(someAnimal);
}