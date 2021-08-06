({
	handleClick : function(cmp, event, helper) {
        let action = cmp.get('c.getAnimal');
        
    	action.setParams({
    		animalId : cmp.get('v.animalId')
		});
        
        action.setCallback(this, function(resp){
            let state = resp.getState();
            console.log('Response: ');
            console.log(resp.getReturnValue().animalListWrapper);
            cmp.set('v.animalListWrapper', resp.getReturnValue().animalListWrapper);
        });
        
        $A.enqueueAction(action);
    }
    
})