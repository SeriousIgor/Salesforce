@isTest
public class AnimalTest {
    @isTest
    public static void getCalloutTest() {
        List<Animal__c> animalList = new List<Animal__c>();
        Animal__c anim = new Animal__c();
        animalList.add(anim);
        Test.setMock(HttpCalloutMock.class, new Animal(animalList));
        insert anim;
       }
}