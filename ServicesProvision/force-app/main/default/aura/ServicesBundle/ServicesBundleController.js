({
	handleClick : function(component, event, helper) {
		console.log('test');
	},
    init : function(cmp, event, helper){
    	var action = cmp.get('c.getAnimal');
    	action.setParams({
    		name : cmp.get('animId')
		});
        action.setCallback(this, function(responce){
            var state = response.getState();
            console.log(response.getReturnValue());
            cmp.set('v.freeResp', response.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})