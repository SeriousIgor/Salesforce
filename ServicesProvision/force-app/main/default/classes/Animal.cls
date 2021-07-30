global class Animal implements Queueable, Database.AllowsCallouts {
    String animalExtId;
    String animalFood;
    String animalSays;
    
    String animalExternalId;
    
    List<Animal__c> animalsList;
    List<Id> animalsId;
    List<String> externalIdList;
    
    public Animal(List<Animal__c> animals){
        animalsId = new List<Id>();
        animalsList = animals;
    }
    
    void setIdList(){
        for(Animal__c a : animalsList){
            animalsId.add(a.id);
        }
    }
    
    public void execute(QueueableContext context){

        setIdList();
        animalsList = [SELECT id, Name, ExternalId__c, Eats__c, Says__c FROM Animal__c WHERE id in: animalsId];
        externalIdList = new List<String>();
        for(Animal__c animal : animalsList){
            externalIdList.add(animal.ExternalId__c);
        }
        parseJSON('https://th-apex-http-callout.herokuapp.com/animals/1');
        update animalsList;
    }
    
    void parseJSON(String link){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(link);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            AnimalJSONtoAPEX animalJSON = AnimalJSONtoAPEX.parse(response.getBody());
            for(Animal__c a : animalsList){
                a.ExternalId__c = String.valueof(animalJSON.animal.Id);
                a.Eats__c = animalJSON.animal.eats;
                a.Name = animalJSON.animal.name;
                a.Says__c = animalJSON.animal.says;
            }
        }
    }
}