({
	
    doinit : function(component, event, helper) {
         var createCarRecord = $A.get("e.force.createRecord");
         helper.getCarTypes(component, helper);
        
        
    },
    
    
    
    onSearchClick : function(component, event, helper) {
        var searchFormSubmit = component.getEvent("searchFormSubmit");
        searchFormSubmit.setParams({
            "carTypeId" : component.find("cartTypeList").get("v.value")
        });
        searchFormSubmit.fire();
	},
    

    
    newvalueselected : function(component, event, helper) {
		var carttypeid = component.find("cartTypeList").get("v.value");
        alert(carttypeid+ 'option selected');
    },
    
    
    createRecord : function (component, event, helper) {
    	var createRecordEvent = $A.get("e.force:createRecord");
    	createRecordEvent.setParams({
        "entityApiName": "CarType__c"
    	});
    	createRecordEvent.fire();
}
    
  
    
})