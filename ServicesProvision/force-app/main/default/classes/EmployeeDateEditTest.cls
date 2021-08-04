@isTest
public class EmployeeDateEditTest {
    @isTest static void setIdListTest(){
        Employee__c emp = new Employee__c();
        insert emp;

        Order__c order = new Order__c(
            Order_Date__c = System.now(),
            Employee__c = emp.id
        );
        Test.startTest();
            insert order;
        Test.stopTest();

        emp = [SELECT id, Last_Order__c FROM Employee__C LIMIT 1];

        System.assertEquals(System.now(), emp.Last_Order__C);
    }
}