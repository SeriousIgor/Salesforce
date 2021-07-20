trigger EditEmployeeTrigger on Order__c (after insert) {
    EmployeeDateEdit emplD = new EmployeeDateEdit();
    emplD.setIdList(Trigger.new);
    update emplD.getEmployeeList();
}