trigger OrdersEditTrigger on Order__c (before insert, after insert, after update) {
    ChangeDateAfterOrderEdit changeDate = new ChangeDateAfterOrderEdit();
    changeDate.setOldRecordMap(Trigger.OldMap);
    changeDate.setIdEmployeeList(Trigger.new);
    update changeDate.getEmployeeList();
}