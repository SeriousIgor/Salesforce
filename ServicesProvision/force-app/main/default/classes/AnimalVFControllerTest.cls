@isTest
private class AnimalVFControllerTest {
    @isTest 
    static void getAnimalTest() {
        ApexPages.StandardController standartController;
        Test.setMock(HttpCalloutMock.class, new ServiceHttpMock());
        Test.startTest();
            AnimalVFController avfc = new AnimalVFController(standartController);
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