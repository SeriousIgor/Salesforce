public class AsyncExecutionParentChild implements Queueable {
    Employee__c empl = null;
    Order__c order = null;
    
    public AsyncExecutionParentChild(String fullName, integer salary, String position){
        empl = new Employee__c(Full_name__c = fullName, Salary__c = salary, Position__c = position);
    }
    
    public AsyncExecutionParentChild(integer price, id emplId){
        order = new Order__c(Price__c = price, Employee__c = emplId);
    }
    
    public void execute(QueueableContext context){
        if(order == null){
            insert empl;
        }
        else{
            insert order;
        }
        System.enqueueJob(new AsyncExecutionParentChild(120, empl.Id));
    }
}