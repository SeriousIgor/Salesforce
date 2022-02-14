global class ExtensionBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Schedulable {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT Id' +
            'FROM Account ' +
            'WHERE '
        );
    }
    global void execute(Database.BatchableContext bc, List<Account> records) {
        // process each batch of records
    }    
    global void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
    }
    global void execute(SchedulableContext sc) {
      ExtensionBatch batch = new ExtensionBatch();
      database.executebatch(batch,100);
}    
}