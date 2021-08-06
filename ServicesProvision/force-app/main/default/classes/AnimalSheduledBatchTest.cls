@isTest
public class AnimalSheduledBatchTest {
    public static String CRON_EXP = '0 0 0 2 6 ? 2022';
    @isTest
    static void testSheduledJob(){
        Animal__c anim = new Animal__c(
            ExternalId__c = '1'
            );
        insert(anim);

        Test.startTest();
        Id jobId = System.schedule('AnimalSheduledBatch', CRON_EXP, new AnimalSheduledBatch());
        Test.stopTest();
    }
}