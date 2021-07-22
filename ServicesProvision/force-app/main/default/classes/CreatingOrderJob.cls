public class CreatingOrderJob implements Queueable {
    integer price;
    id emplId;
    public CreatingOrderJob(integer price, id emplId){
		this.price = price;
        this.emplId = emplId;
    }
    public void execute(QueueableContext context){
        
        Order__c order = new Order__c(Price__c = price, Employee__c = emplId);
        insert order;
    }
}