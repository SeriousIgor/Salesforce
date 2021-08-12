public class AsyncExecutionParentChild implements Queueable {
    private Employee__c empl;
    private Order__c order;
    
    public AsyncExecutionParentChild(String fullName, integer salary, String position){
        empl = new Employee__c(Full_name__c = fullName, Salary__c = salary, Position__c = position);
        System.debug('Test');
    }
    
    public AsyncExecutionParentChild(integer price, id emplId){
        order = new Order__c(Price__c = price, Employee__c = emplId);
        System.debug(order.Price__c + ' | ' + order.Employee__c);
    }
    
    public void execute(QueueableContext context){
        if(order == null){
            System.debug('Order is null');
            insert empl;
            System.enqueueJob(new AsyncExecutionParentChild(120, empl.Id));
        }
        else{
            System.debug('Order is not null');
            insert order;
        }
    }
}