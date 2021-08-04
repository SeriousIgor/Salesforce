@isTest
global class AnimalRestResourceMock implements HttpCalloutMock {
    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setStatusCode(200);
        response.setBody(' {"animal":[{"id":1,"name":"Chicken","eats":"Grain","says":"Cluck"}]} ');
        return response;
    }
}