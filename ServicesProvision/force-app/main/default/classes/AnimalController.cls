global class AnimalController {
	@auraEnabled
    global List<Animal__c> animalList;
    @auraEnabled
    global String animalId;
    
    public AnimalController(String animId){
        animalId = animId;
        if((String.isNotBlank(animalId))&&(animalId instanceOf Id)){
            animalList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c
                           	WHERE id = : ID.valueOf(animalId)];
        }
        else {
        	animalList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c
                           	WHERE ExternalId__c = :animalId];
        }
    }
    
    global List<Animal__c> getAnimal(){
        return animalList;
    }
}