public class EmployeeDateEdit {
    list<Id> idList;
    list<Employee__c> employeeList;
    
    public EmployeeDateEdit(){
        idList = new list<id>();
    }
    
    public void setIdList(list<Order__c> orders){
        for(Order__c ord : orders){
            idList.add(ord.Employee__c);
        }
    }
    void changeList(){
        employeeList = [SELECT id,Last_order__c FROM Employee__c WHERE id in: idList];
        for(Employee__c empl : employeeList){
            if(empl.Last_order__c == null)
        	empl.Last_order__c = System.now();
    	}
    }
    public list<Employee__c> getEmployeeList(){
        changeList();
        return employeeList;
    }
}