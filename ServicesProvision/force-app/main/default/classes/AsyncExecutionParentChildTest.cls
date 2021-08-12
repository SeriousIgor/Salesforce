@isTest
public  class AsyncExecutionParentChildTest {
    @isTest
    public static void asyncExecutionTest(){

        System.enqueueJob(new AsyncExecutionParentChild('Test', 100, 'Test'));

    }
}