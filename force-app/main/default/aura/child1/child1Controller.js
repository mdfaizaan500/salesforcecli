({
	handleclick : function(component, event, helper) {
        var test= $A.get("e.c:testevent13");
        test.setParams({"message":"Faizan"});
        test.fire();
	}
})