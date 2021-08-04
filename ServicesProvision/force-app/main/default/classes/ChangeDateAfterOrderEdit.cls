public class ChangeDateAfterOrderEdit {
	list<Id> idEmployeeList;
    list<Id> oldIdEmployeeList;
    list<Order__c> ordersList;
    list<Employee__c> employeeList;
    list<Employee__c> oldEmployeeList;
    
    public ChangeDateAfterOrderEdit(){
        idEmployeeList = new list<id>();
        oldIdEmployeeList = new list<id>();
    }
    
    public void setIdEmployeeList(list<Order__c> orders, Map<Id, Order__c> ordMap){
        ordersList = orders;
        for(Order__c ord : ordersList){
            if(ord.Employee__c != ordMap.get(ord.id).Employee__c){
                oldIdEmployeeList.add(ordMap.get(ord.id).Employee__c);
            }
            idEmployeeList.add(ord.Employee__c);
        }
    }

    private void changeList(){
        employeeList = [SELECT id,Last_order__c FROM Employee__c WHERE id in: idEmployeeList];
        oldEmployeeList = [SELECT id,Last_order__c FROM Employee__c WHERE id in: oldIdEmployeeList];
        for(Employee__c empl : employeeList){
        	empl.Last_order__c = System.now();
    	}
        for(Employee__c oldE : oldEmployeeList){
            oldE = getNewestDate(oldE);
        }
        employeeList.addAll(oldEmployeeList);
    }

    private Employee__c getNewestDate(Employee__c employee){
        for(Order__c Order : ordersList){

            if(employee.ID == Order.Employee__c){
                System.debug('empl ' + employee.id);
                System.debug('empl ' + employee.Last_order__c);
                System.debug('ord ' + Order.employee__c);
                System.debug('ord ' + Order.Order_Date__c);
                System.debug(employee.Last_order__c < Order.Order_Date__c);
                if((employee.Last_order__c == null)||(employee.Last_order__c < Order.Order_Date__c)){
                    employee.Last_order__c = Order.Order_Date__c;
                }
            }
        }
        return employee;
    }

    public list<Employee__c> getEmployeeList(){
        changeList();
        return employeeList;
    }
}