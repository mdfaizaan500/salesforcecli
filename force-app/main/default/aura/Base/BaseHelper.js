({
	callServer : function(component, method, callback, params) {
        var action= component.get(method);
        if(params){
            action.setParams(params);
        }
        
        action.setCallback(this,function(response){
                  var state = response.getState();
                           if(state == "SUCCESS"){
                               callback.call(this,response.getReturnValue());
          //  component.set("v.CarTypes",response.getReturnValue());
        }
        else if(state ==="ERROR"){
                alert('unknown error');
               }
               });
        $A.enqueueAction(action);
		
	}
})