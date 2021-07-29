public with sharing class BatchEmployeeOrders implements Database.Batchable<SObject> {
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Start');
        return Database.getQueryLocator('SELECT id, Order_date__c, Employee__c from Order__c');
    }
    
    public void execute(Database.BatchableContext bc, List<Order__c> orderListFromStartMethod){
        Employee__c employee;
        for(Order__c order : orderListFromStartMethod){
            System.debug(order.id);
            employee = [SELECT ID, Last_Order__c FROM Employee__c where id =: order.Employee__c];
            if(employee.Last_order__c > order.Order_Date__c){
                employee.Last_order__c = order.Order_Date__c;
                insert employee;
            }
        }

    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch job completed');
    }

}