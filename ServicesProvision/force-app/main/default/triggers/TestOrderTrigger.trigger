trigger TestOrderTrigger on Order__c (before insert) {
    for(Order__c ord : Trigger.new) {
        ord.Order_Date__c = system.now();
    }
}