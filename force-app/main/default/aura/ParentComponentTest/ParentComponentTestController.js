({
	myAction : function(component, event, helper) {
        console.log("event handled");
		var Parentvalue = event.getParam("Demochild");
        alert('@@@@'+Parentvalue );
	}
})