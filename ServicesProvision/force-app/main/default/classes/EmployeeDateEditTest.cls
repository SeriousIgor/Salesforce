@isTest
private class EmployeeDateEditTest {
    @TestSetup
    static void setup(){
        TestDataFactory.createEmployeeWithOrders(3, 3);
    }

    @isTest static void setIdListTest(){
        Order__c order = [SELECT id, Order_Date__c, Employee__c FROM Order__c LIMIT 1];
        List<Employee__c> employeeList = [SELECT id FROM Employee__c];

        for(Employee__c e : employeeList){
            if(order.Employee__c != e.id){
                order.Employee__c = e.id;
                break;
            }
        }
        Test.startTest();
        update order;
        Test.stopTest();
    }
}