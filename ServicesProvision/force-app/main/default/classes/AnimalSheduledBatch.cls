global class AnimalSheduledBatch implements Schedulable {
    global void execute(SchedulableContext SC) {
        List<Animal__c> animalList = [SELECT Id, Name, Says__c, Eats__c, ExternalId__c FROM Animal__c];
        Animal animal = new Animal(animalList);
    }
}