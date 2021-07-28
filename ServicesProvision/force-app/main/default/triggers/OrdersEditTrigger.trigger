trigger OrdersEditTrigger on Order__c (after update) {
    ChangeDateAfterOrderEdit changeDate = new ChangeDateAfterOrderEdit();
    changeDate.setIdEmployeeList(Trigger.new, Trigger.OldMap);
    update changeDate.getEmployeeList();
}