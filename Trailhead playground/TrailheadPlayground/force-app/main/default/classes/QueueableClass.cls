public class QueueableClass implements Queueable, Database.Stateful, Database.AllowsCallouts { 
    public void execute(QueueableContext context) {
        // awesome code here
    }
}