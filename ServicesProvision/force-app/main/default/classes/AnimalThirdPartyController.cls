public  class AnimalThirdPartyController {
    static Animal__c animal;
    static String externalId;

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
    public static void insertAnimal(){
        if(checkForDublicate()){
            
        }
        else{
            insert animal;
        }
        
    }
    private static Boolean checkForDublicate(){
        List<Animal__c> animalList = [SELECT Name, Eats__c, Says__c, ExternalId__c FROM Animal__c WHERE ExternalId__c =: externalId];
        if(animalList.size() > 0){
            return true;
        }
        else {
            return false;
        }
    }
}
