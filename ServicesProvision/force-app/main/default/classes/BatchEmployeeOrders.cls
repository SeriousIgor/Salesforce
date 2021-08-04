global with sharing class BatchEmployeeOrders implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Start');
        return Database.getQueryLocator('SELECT id, Order_date__c, Employee__c from Order__c');
    }
    
    global void execute(Database.BatchableContext bc, List<Order__c> orderListFromStartMethod){
        Employee__c employee;
        for(Order__c order : orderListFromStartMethod){
            System.debug(order.id);
            employee = [SELECT ID, Last_Order__c FROM Employee__c where id =: order.Employee__c];
            System.debug('Employee ' + employee.Last_order__c);
            System.debug('Order ' + order.Order_Date__c);
            if(employee.Last_order__c < order.Order_Date__c){
                employee.Last_order__c = order.Order_Date__c;
                insert employee;
            }
        }

    }
    global void finish(Database.BatchableContext bc){
        Id job = bc.getJobId();
        System.debug('Batch job completed');
    }

}