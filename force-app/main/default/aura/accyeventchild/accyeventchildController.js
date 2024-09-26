({
	handleclick : function(component, event, helper) {
        var accyev = $A.get("e.c:accyevent");
        accyev.setParams({"ctsname":"Accenture"});
        accyev.fire();
	}
})