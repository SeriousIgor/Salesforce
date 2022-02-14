public class IterableBatch implements Database.Batchable<sObject> {
    public System.Iterable<SObject> start(Database.BatchableContext bc) {
        // collect the batches of records or objects to be passed to execute
        return [
            SELECT Id
            FROM Contact
        ];
    }
    public void execute(Database.BatchableContext bc, List<Contact> records) {
        // process each batch of records
    }    
    public void finish(Database.BatchableContext bc) {
        // execute any post-processing operations
    }

    public String stringMethod(){
        String var;
        return var;
    }
        
}