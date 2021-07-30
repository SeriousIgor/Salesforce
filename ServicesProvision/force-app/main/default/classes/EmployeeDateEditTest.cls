@isTest
private class EmployeeDateEditTest {
    @isTest static void testChangeList(){
        EmployeeDateEdit ede = new EmployeeDateEdit();
    }
    @isTest static void testSetIdList(){
        EmployeeDateEdit ede = new EmployeeDateEdit();
        List<Order__c> orderList = [SELECT id, Employee__c FROM Order__c LIMIT 10];
        List<Id> idlist = new List<Id>();

        for(Order__c order : orderList){
            idList.add(order.Employee__c);
        }
        ede.setIdList(orderList);

        System.assertEquals(idList, ede.idList);
    }
    
    @isTest static void testGetEmployeeList(){
        EmployeeDateEdit ede = new EmployeeDateEdit();
        List<Order__c> orderList = [SELECT id, Employee__c FROM Order__c LIMIT 10];
        List<Id> idlist = new List<Id>();

        for(Order__c order : orderList){
            idList.add(order.Employee__c);
        }
        List<Employee__c> employeeList = [SELECT id, Last_order__c FROM Employee__c where id in : idlist];
        for(Employee__c employee : employeeList){
            employee.Last_order__c = System.now();
        }
        ede.idList = idlist;

        System.assertEquals(employeeList, ede.getEmployeeList());
        
    }
}