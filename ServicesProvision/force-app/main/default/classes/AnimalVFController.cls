public class AnimalVFController {
    private final Animal__c anim;
    
    public String eats {get;set;}
    public String says {get;set;}
    public String aName {get;set;}
    public String extId {get;set;}

    public AnimalVFController(ApexPages.StandardController stdController){
        anim = (Animal__c)stdController.getRecord();
    }

    public Pagereference getAnimal(){
        Animal__c animal;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + String.valueOf(anim.externalId__c));
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            animal = new Animal__c(ExternalId__c = anim.externalId__c);

            AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
                animal.Eats__c = animalJSON.animal.eats;
                animal.Name = animalJSON.animal.name;
                animal.Says__c = animalJSON.animal.says;
        }
        if((!String.isBlank(animal.Name))
        ||(!String.isBlank(animal.Eats__c))
        ||(!String.isBlank(animal.Says__c))){
            eats = animal.Eats__c;
            says = animal.Says__c;
            aName = animal.Name;
            extId = animal.ExternalId__c;
        }
        
        return null;
    }
}
