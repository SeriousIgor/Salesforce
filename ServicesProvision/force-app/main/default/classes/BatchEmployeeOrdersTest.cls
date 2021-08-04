@isTest
public class BatchEmployeeOrdersTest {
    @isTest
    public static void recordsCreationTest(){
        Employee__c emp = new Employee__c();
        insert emp;
        Order__c order = new Order__c(
            Order_Date__c = System.now(),
            Employee__c = emp.id
        );
        insert order;
        emp = [SELECT id, Last_Order__c FROM Employee__C LIMIT 1];
        emp.Last_order__c = Datetime.newInstance(2013, 5, 28, 1, 6, 8);
        update emp;

        Test.startTest();
        BatchEmployeeOrders beo = new BatchEmployeeOrders();
        Id jobId = Database.executeBatch(beo);
        Test.stopTest();
    }
}