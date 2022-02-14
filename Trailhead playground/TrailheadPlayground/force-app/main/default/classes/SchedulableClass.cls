public class SchedulableClass implements Database.Batchable<sObject>, Schedulable {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return Database.getQueryLocator(
            'SELECT Id' +
            'FROM Contact ' +
            'WHERE '
        );
    }
    public void execute(Database.BatchableContext bc, List<Contact> records) {
        // process each batch of records
    }    
    public void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
    }
    public void execute(SchedulableContext sc) {
      SchedulableClass batch = new SchedulableClass();
      database.executebatch(batch,100);
}    
}