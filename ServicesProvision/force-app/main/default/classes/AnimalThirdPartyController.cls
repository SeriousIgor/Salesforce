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
        if (response.getStatusCode() == 200) {
            animal = new Animal__c(
            ExternalId__c = externalId,
            Flag__c = true
            );
            System.debug('Response code is 200');
            AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
                animal.Eats__c = animalJSON.animal.eats;
                animal.Name = animalJSON.animal.name;
                animal.Says__c = animalJSON.animal.says;
        }
        if((String.isBlank(animal.Name))
        &&(String.isBlank(animal.Eats__c))
        &&(String.isBlank(animal.Says__c))){
            resultAnimal = 'Empty';
        }
        else{
            resultAnimal = 'Name:' + animal.Name + '|Eats:' + animal.Eats__c + '|Says:' + animal.Says__c;
        }
        return resultAnimal;
    }

    @AuraEnabled
    public static Boolean checkForDublicate(String extId){
        animalList = [SELECT Name, Eats__c, Says__c, ExternalId__c FROM Animal__c WHERE ExternalId__c =: extId];

        if(animalList.size() > 0){
            return true;
        }
        else {
            return false;
        }
    }

    @AuraEnabled
    public static void insertAnimal(String extId){
        if(getAnimalId(extId) != 'Empty'){
            insert animal;
        }
    }

    @AuraEnabled
    public static void replaceValueInRecord(String extId){
        getAnimalId(extId);
        animalList = [SELECT Name, Eats__c, Says__c, ExternalId__c FROM Animal__c WHERE ExternalId__c =: extId];
        for(Animal__c a : animalList){
            System.debug(a.Name + ' - ' + animal.Name);
            a.Name = animal.Name;
            a.Eats__c = animal.Eats__c;
            a.Says__c = animal.Says__c;
        }
        update animalList;
    }
}