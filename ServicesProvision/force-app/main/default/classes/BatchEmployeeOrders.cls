global with sharing class BatchEmployeeOrders implements Database.Batchable<SObject> {
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        System.debug('Start');
        return Database.getQueryLocator('SELECT id, Order_date__c, Employee__c, Employee__r.Last_Order__c from Order__c');
    }
    
    global void execute(Database.BatchableContext bc, List<Order__c> orderListFromStartMethod){
        for(Order__c order : orderListFromStartMethod){
            Employee__c employee = new Employee__c();
            employee.Id = order.Employee__c;
            if(order.Employee__r.Last_Order__c < order.Order_Date__c){
                employee.Last_order__c = order.Order_Date__c;
                update employee;
            }
        }

    }
    global void finish(Database.BatchableContext bc){
        Id job = bc.getJobId();
        System.debug('Batch job completed');
    }

}