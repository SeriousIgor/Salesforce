public class AsyncExecutionParentChild implements Queueable {
	integer salary;
    String position;
    String fullName;
    
    integer price;
    id emplId;
    Employee__c empl;
    Order__c order;
    
    public AsyncExecutionParentChild(String fullName, integer salary, String position){
        this.fullName = fullName;
        this.salary = salary;
        this.position = position;
    }
    
    public AsyncExecutionParentChild(integer price, id emplId){
        this.price = price;
        this.emplId = emplId;
    }
    
    public void execute(QueueableContext context){
        if(order == null){
            empl = new Employee__c(Full_name__c = fullName, Salary__c = salary, Position__c = position);
            insert empl;
        }
        else{
            order = new Order__c(Price__c = price, Employee__c = emplId);
            insert order;
        }
        System.enqueueJob(new AsyncExecutionParentChild(120, empl.Id));
    }
}