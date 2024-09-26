({
	
    
    getCarTypes : function(component, helper) {
        
        var action = component.get("c.Cartypesavailable");
        action.setCallback(this,function(data){
                  var state = data.getState();
                           if(state == "SUCCESS"){
            component.set("v.CarTypes",data.getReturnValue());
        }
        else if(state ==="ERROR"){
                alert('unknown error');
               }
               });
        $A.enqueueAction(action); 
        } 
                                         
 /*    helper.callServer(component, "c.Cartypesavailable",  function(response){
    component.set("v.CarTypes",response);
}); */
        

     
    
    
})