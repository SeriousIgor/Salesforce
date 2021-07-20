public class ChangeDateAfterOrderEdit {
	list<Id> idEmployeeList;
    list<Id> oldIdEmployeeList;
    list<Employee__c> employeeList;
    list<Employee__c> oldEmployeeList;
    
    public ChangeDateAfterOrderEdit(){
        idEmployeeList = new list<id>();
        oldIdEmployeeList = new list<id>();
    }
    
    public void setOldIdEmployeeList(list<Order__c> orders){
        for(Order__c ord : orders){
            oldIdEmployeeList.add(ord.Employee__c);
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
    public void changeOldList(){
        oldEmployeeList = [SELECT id,Last_order__c FROM Employee__c WHERE id in: oldIdEmployeeList];
        if(employeeList != null)
        for(Employee__c empl : employeeList){
        	empl.Last_order__c = null;
    	}
    }
    public list<Employee__c> getOldEmployeeList(){
        changeOldList();
        return oldEmployeeList;
    }
    public list<Employee__c> getEmployeeList(){
        changeList();
        return employeeList;
    }
}