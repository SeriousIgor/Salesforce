public  class AnimalThirdPartyController {
    static Animal__c animal;
    static String externalId;
    static List<Animal__c> animalList;

    @AuraEnabled(cacheable=true)
    public static Animal__c getAnimalId(String extId){
        externalId = extId;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + String.valueOf(externalId));
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        animal = new Animal__c(
            ExternalId__c = externalId
        );
        if (response.getStatusCode() == 200) {
            AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
                animal.Eats__c = animalJSON.animal.eats;
                animal.Name = animalJSON.animal.name;
                animal.Says__c = animalJSON.animal.says;
        }
        return animal;
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
    public static void insertAnimal(){
        insert animal;
    }

    @AuraEnabled
    public static void replaceValueInRecord(){
        for(Animal__c a : animalList){
            a.Name = animal.Name;
            a.Eats__c = animal.Eats__c;
            a.Says__c = animal.Says__c;
        }
    }
}