@isTest
public class ChangeDateAfterOrderEditTest {
    @TestSetup
    static void setup(){
        TestDataFactory.createEmployeeWithOrders(3, 3);
    }

    @isTest
    public static void setIdEmployeeListTest(){
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
    @isTest
    public static void getNewestDateTest(){
        Employee__c employee = [SELECT id, Last_Order__c FROM Employee__c LIMIT 1];
        List<Order__c> orders = [SELECT id, Order_Date__c, Employee__c FROM Order__c];

        for(Order__c o : orders){
            if(o.Employee__c != employee.id){
                o.Employee__c = employee.id;
                o.Order_Date__c = Datetime.newInstance(2022,1,1,12,0,0);
            }
        }

        Test.startTest();
        update orders;
        Test.stopTest();
    }
}