trigger AnimalFilling on Animal__c (after insert) {
	Animal someAnimal = new Animal(Trigger.new);
    someAnimal.setIdList();
    System.enqueueJob(someAnimal);
    someAnimal.parseJSON('https://th-apex-http-callout.herokuapp.com/animals/1');
    update someAnimal.getAnimalsList();
}