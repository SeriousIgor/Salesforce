({
	handleClick : function(cmp, event, helper) {
        var action = cmp.get('c.getAnimal');
    	action.setParams({
    		animalId : cmp.get('v.animalId')
		});
        action.setCallback(this, function(resp){
            var state = resp.getState();
            console.log('Response: ');
            console.log(resp.getReturnValue());
            cmp.set('v.freeResp', resp.getReturnValue());
        });
        $A.enqueueAction(action);
    }
    
})