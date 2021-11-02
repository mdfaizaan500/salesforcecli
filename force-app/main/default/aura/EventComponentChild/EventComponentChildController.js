({
	fireComponentEvent : function(component, event, helper) {
		var cmpevnt = component.getEvent("cmpEvent");
        cmpevnt.setParams({
            "message" : "A component event fired me. "});
        cmpevnt.fire();
	}
})