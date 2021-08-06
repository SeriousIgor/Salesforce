@isTest
public class AnimalTest {
    @isTest
    public static void getCalloutTest() {
        Animal__c anim = new Animal__c(
            Name = 'chicken'
        );
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        Test.startTest();
        insert anim;
        Test.stopTest();

        anim = [SELECT Id, Name, Eats__c, Says__c, ExternalId__c FROM Animal__c LIMIT 1];

        System.assertEquals('Grain', (String) anim.Eats__c);
        System.assertEquals('Cluck', (String) anim.Says__c);
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