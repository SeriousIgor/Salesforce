trigger OrdersEditTrigger on Order__c (after insert, after update) {
    ChangeDateAfterOrderEdit changeDate = new ChangeDateAfterOrderEdit();
    changeDate.setIdEmployeeList(Trigger.new);
    update changeDate.getEmployeeList();
}