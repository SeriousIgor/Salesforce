@isTest
public class AnimalRestResourceTest {
    @TestSetup
    static void setUp(){
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        Animal__c anim = new Animal__c(
            Name = 'chicken',
            ExternalId__c = '1',
            Eats__c = 'chicken food',
            Says__c = 'c',
            Flag__c = true
        );
        insert anim;
    }
    @isTest
    public static void getAllRecordsTest(){
        //Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        Test.startTest();
        getRequestSetup('');
        List<Animal__c> animalList = AnimalRestResource.getRecord();
        Test.stopTest();

        System.assertNotEquals(0, animalList.size());
    }
    @isTest
    public static void getRecordByExtrenalIdTest(){
        //Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        Test.startTest();
        getRequestSetup('1');
        List<Animal__c> animalList = AnimalRestResource.getRecord();
        Test.stopTest();

        System.assertEquals('chicken food', animalList[0].Eats__c);
    }
    @isTest
    public static void getRecordByIdTest(){
        Test.startTest();
        Animal__c anim = [SELECT id FROM Animal__c LIMIT 1];
        getRequestSetup(anim.id);
        List<Animal__c> animalList = AnimalRestResource.getRecord();
        Test.stopTest();

        System.assertEquals('c', animalList[0].Says__c);
    }
    @isTest
    public static void createAnimalDbTest(){
        String rBody = '{"animal":{"id":3,"name":"goose","eats":"goose food","says":"something on goose language"}}';
        Animal__c anim = new Animal__c(
            Name = 'goose',
            ExternalId__c = '3',
            Eats__c = '',
            Says__c = '',
            Flag__c = true
        );
        insert anim;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMockOtherResponse());
        postRequestSetup(rBody);
        Id animalId = AnimalRestResource.createAnimal();
        Test.stopTest();

        List<Animal__c> animalList = [SELECT Eats__c FROM Animal__c WHERE Id =:anim.Id];

        System.assertEquals('goose food', animalList[0].Eats__c);
    }
    @isTest
    public static void createAnimalThirdPartyTest(){
        String rBody = '{"animal":{"id":3,"name":"goose","eats":"goose food","says":"something on goose language"}}';
        Animal__c anim = [SELECT Says__c, Eats__c FROM Animal__c LIMIT 1];
        anim.Says__c = null;
        anim.Eats__c = null;
        update anim;

        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        postRequestSetup(rBody);
        Id animalId = AnimalRestResource.createAnimal();
        Test.stopTest();

    }
    @isTest
    public static void createNewAnimalTest(){
        String rBody = '{"animal":{"id":5,"name":"a","eats":"aa","says":"aaa"}}';
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        postRequestSetup(rBody);
        Id animalId = AnimalRestResource.createAnimal();
        Test.stopTest();

        List<Animal__c> animalList = [SELECT Name FROM Animal__c WHERE ExternalId__c =: '5'];

        System.debug(animalList[0].Name);

        System.assertEquals('a', animalList[0].Name);
    }

    private static void getRequestSetup(String animalId){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Animal/' + animalId;
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.params.put('id', '3');
        req.params.put('name', 'goose');
        req.params.put('eats', 'goose food');
        req.params.put('says', 'something on goose language');
        RestContext.request = req;
        RestContext.response = res;
    }

    private static void postRequestSetup(String rBody){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Animal/';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');
        req.requestBody = Blob.valueOf(rBody);
        RestContext.request = req;
        RestContext.response = res;
    }

    public class ServiceHttpMock implements HttpCalloutMock  {
        public HTTPResponse respond(HTTPRequest req) {
            Map<String, Object> responseMap = new Map<String, Object>();
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json;charset=UTF-8');
            res.setBody('{"animal":{"id":3,"name":"goose","eats":"goose food","says":"something on goose language"}}');
            res.setStatusCode(200);
            return res;
        }
    }

    public class ServiceHttpMockOtherResponse implements HttpCalloutMock  {
        public HTTPResponse respond(HTTPRequest req) {
            Map<String, Object> responseMap = new Map<String, Object>();
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json;charset=UTF-8');
            res.setBody('{"animal":{"id":3,"name":"goose","eats":"goose food","says":"something on goose language"}}');
            res.setStatusCode(500);
            return res;
        }
    }
}