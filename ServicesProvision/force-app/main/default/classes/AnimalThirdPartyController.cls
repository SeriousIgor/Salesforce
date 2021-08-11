public  class AnimalThirdPartyController {
    static Animal__c animal;
    static String externalId;
    static List<Animal__c> animalList;

    @AuraEnabled(cacheable=true)
    public static String getAnimalId(String extId){
        System.debug('getAnimalId');
        String resultAnimal;
        externalId = extId;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + String.valueOf(externalId));
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        animal = new Animal__c(
            ExternalId__c = externalId,
            Flag__c = true

        );
        if (response.getStatusCode() == 200) {
            System.debug('Response code is 200');
            AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
                animal.Eats__c = animalJSON.animal.eats;
                animal.Name = animalJSON.animal.name;
                animal.Says__c = animalJSON.animal.says;
        }
        if(animal != null){
            resultAnimal = 'Name : ' + animal.Name + ' | Eats : ' + animal.Eats__c + ' | Says : ' + animal.Says__c;
        }
        else{
            resultAnimal = 'empty';
        }
        return resultAnimal;
    }

    @AuraEnabled
    public static Boolean checkForDublicate(){
        animalList = [SELECT Name, Eats__c, Says__c, ExternalId__c FROM Animal__c WHERE ExternalId__c =: externalId];
        if(animalList.size() > 0){
            return true;
        }
        else {
            return false;
        }
    }

    @AuraEnabled
    public static void insertAnimal(String extId){
        if(getAnimalId(extId) != 'empty'){
            insert animal;
        }
    }

    @AuraEnabled
    public static void replaceValueInRecord(String extId){
        getAnimalId(extId);
        for(Animal__c a : animalList){
            a.Name = animal.Name;
            a.Eats__c = animal.Eats__c;
            a.Says__c = animal.Says__c;
        }
        update animalList;
    }
}