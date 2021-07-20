trigger OrdersEditTrigger on Order__c (before insert, before update, after insert, after update) {
    ChangeDateAfterOrderEdit changeDate = new ChangeDateAfterOrderEdit();
    changeDate.setOldIdEmployeeList(Trigger.old);
    update changeDate.getOldEmployeeList();
    changeDate.setIdEmployeeList(Trigger.new);
    update changeDate.getEmployeeList();
}