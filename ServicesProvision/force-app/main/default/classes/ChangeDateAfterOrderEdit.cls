public class ChangeDateAfterOrderEdit {
	list<Id> idEmployeeList;
    list<Id> oldIdEmployeeList;
    list<Employee__c> employeeList;
    
    public ChangeDateAfterOrderEdit(){
        idEmployeeList = new list<id>();
        oldIdEmployeeList = new list<id>();
    }
    
    public void setOldRecordMap(Map<id, Order__c> ordMap){
        for(Order__c oldOrder : ordMap.values()){
            oldIdEmployeeList.add(oldOrder.Employee__c);
        }
    }
    
    public void setIdEmployeeList(list<Order__c> orders){
        for(Order__c ord : orders){
            idEmployeeList.add(ord.Employee__c);
        }
    }
    public void changeList(){
        employeeList = [SELECT id,Last_order__c FROM Employee__c WHERE id in: idEmployeeList];
        for(Employee__c empl : employeeList){
        	empl.Last_order__c = System.now();
    	}
    }
    public list<Employee__c> getEmployeeList(){
        changeList();
        return employeeList;
    }
}