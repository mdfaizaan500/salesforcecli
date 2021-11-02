({
	myAction : function(component, event, helper) {
		var Getdata = component.getEvent("Demochild1");
        Getdata.setParams({"Demochild":"Faizanhello"});
        Getdata.fire();
        console.log("event fired");
	}
})