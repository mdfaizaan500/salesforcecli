({
	
    doInit : function(component, event, helper) {
    console.log('Init fired');
        var action = component.get("c.accessAuthorization");
		var userIdVal = $A.get("$SObjectType.CurrentUser.Id");
        action.setParams({  userid : userIdVal });
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                component.set("v.ListOfAuthorization", result);
            }
        });
        $A.enqueueAction(action);      
    },
    openMenu : function(component, event, helper) {
		helper.openMenu(component);
	},
    
    closeMenu : function(component, event, helper) {
		helper.closeMenu(component);
	}
})