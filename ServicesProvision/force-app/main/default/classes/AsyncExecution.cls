public class AsyncExecution implements Queueable {
    integer salary;
    String position;
    public AsyncExecution(integer salary, String position){
        this.salary = salary;
        this.position = position;
    }
    
    public void execute(QueueableContext context){
		Employee__c empl = new Employee__c(Salary__c = salary, Position__c = position);
        insert empl;
        
        System.enqueueJob(new CreatingOrderJob(120, empl.Id));
    }
}