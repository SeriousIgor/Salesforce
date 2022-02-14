global class TestBatch implements Database.Batchable<sObject>, Schedulable {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT Id' +
            'FROM Contact ' +
            'WHERE '
        );
    }
    global void execute(Database.BatchableContext bc, List<Contact> records) {
        // process each batch of records
    }    
    global void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
    }
    global void execute(SchedulableContext sc) {
      TestBatch batch = new TestBatch();
      database.executebatch(batch,100);
}    
}