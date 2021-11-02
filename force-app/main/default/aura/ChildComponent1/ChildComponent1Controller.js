({
	myAction : function(component, event, helper) {
		var cmpevent=component.getEvent("cmpevt");
        cmpevent.setParams({"Demoname":"faizan"});
        cmpevent.fire();
	}
})