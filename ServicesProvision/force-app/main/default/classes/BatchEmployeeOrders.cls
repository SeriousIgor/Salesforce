public with sharing class BatchEmployeeOrders implements Database.Batchable<SObject> {
    List<Order__c> orders;
    public Database.QueryLocator start(Database.BatchableContext bc){
        orders = new List<Order__c>();
        return Database.getQueryLocator('SELECT id, Full_name__c from Employee__c');
    }
    public void execute(Database.BatchableContext bc, List<Employee__c> empListFromStartMethod){
        for(Employee__c empl : empListFromStartMethod){
            
        }

    }
    public void finish(Database.BatchableContext bc){
        System.debug('Batch job completed');
    }

}