({
	handleclick : function(component, event, helper) {
		var test = component.getEvent("chlEvent");
        test.setParams({"DiaName":"Faizan"});
        test.fire();        
	}
})