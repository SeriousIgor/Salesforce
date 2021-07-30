@RestResource(urlMapping='/Animal/*')
global without sharing class AnimalRestResource {
    @HttpGet
    global static List<Animal__c> getRecord(){        
        RestRequest request = RestContext.request;
        String animalId = request.requestURI.substring(
        	request.requestURI.lastIndexOf('/')+1);
        List<Animal__c> resultList;
        if((String.isNotBlank(animalId))&&(animalId instanceOf Id)){
            resultList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c
                           	WHERE id = : ID.valueOf(animalId)];
        }
        else if(String.isNotBlank(animalId)){
        	resultList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c
                           	WHERE ExternalId__c = :animalId];
        }
        else
        {
            resultList = [SELECT Name, ExternalId__c, Eats__c, Says__c FROM Animal__c];
        }
        return resultList;
    }
    @HttpPost
    global static Id createAnimal() {
        boolean isUnique = true;
        List<Boolean> flags = new List<Boolean>();
        Id returnedId = null;
        
        Map<String, Object> params = (Map<String, Object>) JSON.deserializeUntyped(RestContext.request.requestBody.toString());
        Map<String, Object> textBody = (Map<String, Object>)params.get('animal');	
        String externalId = String.valueOf(textBody.get('id'));
        String says = (String) textBody.get('says');
        String eats = (String) textBody.get('eats');
        String name = (String) textBody.get('name');
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/1');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        
        List<Animal__c> animalsList = [SELECT id, Name, ExternalId__c, Says__c, Eats__c FROM Animal__c];
        
        for(Animal__c anim : animalsList){
            if(anim.ExternalID__c == externalID){
                System.debug('if');
                if(anim.Name == null){
                    anim.Name = name;
                }
                if(anim.Says__c == null){
                    anim.Says__c = says;
                }
                if(anim.Eats__c == null){
                    anim.Eats__c = eats;
                }
                flags.add(false);
                System.debug('false');
            }
            else if (response.getStatusCode() == 200) {
                System.debug('else if');
                AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
                    if(externalId == String.valueof(animalJSON.animal.Id)){
                        System.debug('else if - if');
                        if(anim.Eats__c == null)
                        anim.Eats__c = animalJSON.animal.eats;
                        if(anim.Name == null)
                        anim.Name = animalJSON.animal.name;
                        if(anim.Says__c == null)
                        anim.Says__c = animalJSON.animal.says;
                        flags.add(false);
                        System.debug('false');
                    }
                    else{
                        flags.add(true);
                        System.debug('true');
                    }
            }
            else{
                flags.add(true);
                System.debug('true');
            }
        }
        for(boolean f : flags){
            if(!f){
                isUnique = false;
            }
        }
        if(isUnique){
            System.debug('Else');
            Animal__c newAnimal = new Animal__c();
            newAnimal.Name = name;
            newAnimal.Says__c = says;
            newAnimal.Eats__c = eats;
            newAnimal.ExternalId__c = ExternalId;
            newAnimal.Flag__c = true;
            insert newAnimal;
            returnedId = newAnimal.id;
        }
        System.debug('Animal list size - ' + animalsList.size());
        update animalsList;
        return returnedId;
    }
}