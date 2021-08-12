@isTest
public class AnimalThirdPartyControllerTest {
    @isTest
    public static void getAnimalIdTest(){
        Animal__c animal = new Animal__c();
        
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        insert animal;
        String result;

        Test.startTest();
            result = AnimalThirdPartyController.getAnimalId('1');
        Test.stopTest();
        System.assertEquals('Name : Chicken | Eats : Grain | Says : Cluck', result);
    }
    @isTest
    public static void checkForDublicatesTest(){
        Animal__c animal = new Animal__c(ExternalId__c = '1');
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        insert animal;
        Boolean result;

        Test.startTest();
        result = AnimalThirdPartyController.checkForDublicate('1');
        Test.stopTest();

        System.assert(result);
    }
    @isTest
    public static void insertAnimalTest(){
        Animal__c animal = new Animal__c(ExternalId__c = '1');
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        insert animal;

        Test.startTest();
        AnimalThirdPartyController.insertAnimal('1');
        Test.stopTest();
    }
    @isTest
    public static void replaceValueInRecord(){
        Animal__c animal = new Animal__c(ExternalId__c = '1');
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        insert animal;

        Test.startTest();
        AnimalThirdPartyController.replaceValueInRecord('1');
        Test.stopTest();
    }

    public class ServiceHttpMock implements HttpCalloutMock  {
        public HTTPResponse respond(HTTPRequest req) {
            Map<String, Object> responseMap = new Map<String, Object>();
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json;charset=UTF-8');
            res.setBody('{"animal":{"id":1,"name":"Chicken","eats":"Grain","says":"Cluck"}}');
            res.setStatusCode(200);
            return res;
        }
    }
}