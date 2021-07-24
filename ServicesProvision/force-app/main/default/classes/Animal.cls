global class Animal implements Queueable {
    Id animalId;
    String animalFood;
    String animalSays;
    
    String animalExternalId;
    
    List<Animal__c> animals;
    List<Id> animalsId;
    List<String> externalIdList;
    
    public Animal(List<Animal__c> animals){
        this.animals = animals;
    }
    
    public void setIdList(){
        for(Animal__c a : animals){
            animalsId.add(a.id);
        }
    }
    
    public void execute(QueueableContext context){
        animals = [SELECT id, Name, ExternalId__c, Eats__c, Says__c FROM Animal__c WHERE id in: animalsId];
        externalIdList = new List<String>();
        for(Animal__c animal : animals){
            externalIdList.add(animal.ExternalId__c);
        }
    }
    
    public void parseJSON(String link){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(link);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
            for(Animal__c a : animals){
                a.ExternalId__c = String.valueof(animalJSON.animal.Id);
                a.Eats__c = animalJSON.animal.eats;
                a.Name = animalJSON.animal.name;
                a.Says__c = animalJSON.animal.says;
            }
        }
    }
    
    public List<Animal__c> getAnimalsList(){
        return animals;
    }
}