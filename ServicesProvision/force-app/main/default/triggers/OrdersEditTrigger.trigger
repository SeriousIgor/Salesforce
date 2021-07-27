trigger OrdersEditTrigger on Order__c (before insert, after insert, after update) {
    ChangeDateAfterOrderEdit changeDate = new ChangeDateAfterOrderEdit();
    changeDate.setIdEmployeeList(Trigger.new, Trigger.OldMap);
    update changeDate.getEmployeeList();
}