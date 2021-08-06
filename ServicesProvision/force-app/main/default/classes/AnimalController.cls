public class AnimalController {

    @AuraEnabled
    public static AnimalListWrapper getAnimal(String animalId){
        List<AnimalWrapper> aWrapperList = new List<AnimalWrapper>();
        List<Animal__c> animalList;

        if((String.isNotBlank(animalId))&&(animalId instanceOf Id)){
            System.debug('Get by id');
            animalList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c WHERE id = : ID.valueOf(animalId)];
        }
        else {
            System.debug('Get by externalId');
        	animalList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c WHERE ExternalId__c = :animalId];
        }

        for(Animal__c a : animalList){
            System.debug('Animal name ' + a.Name);
            AnimalWrapper animalWrapper = new AnimalWrapper(a.Name, a.says__c, a.eats__c, a.externalId__c);
            aWrapperList.add(animalWrapper);
        }
        AnimalListWrapper animalListWrapper = new AnimalListWrapper();
        animalListWrapper.animalListWrapper = aWrapperList;
        
        return animalListWrapper;
    }

    public class AnimalListWrapper {
        @AuraEnabled
        public List<AnimalWrapper> animalListWrapper{get;set;}

        public AnimalListWrapper(){

        }
    }

    public class AnimalWrapper {
        @AuraEnabled
        public String name {get;set;}
        @AuraEnabled
        public String says{get;set;}
        @AuraEnabled
        public String eats{get;set;}
        @AuraEnabled
        public String externalId{get;set;}
        
        public AnimalWrapper(String name, String says, String eats, String externalId){
            this.name = name;
            this.says = says;
            this.eats = eats;
            this.externalId = externalId;
        }
    }

}