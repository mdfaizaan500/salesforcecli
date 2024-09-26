({
	
    doInit : function(component, event, helper) {
    console.log('Init fired');
        var action = component.get("c.CountryType");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS"){
                var result = response.getReturnValue();
                var plValues = [];
                for (var i = 0; i < result.length; i++) {
                    plValues.push({
                        label: result[i],
                        value: result[i]
                    });
                }
                component.set("v.showpicklist", plValues);
            }
        });
        $A.enqueueAction(action);       
    }
})