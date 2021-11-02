({
	myAction : function(component, event, helper) {
		//component.set('v.Name','Faizan');
		var col=[
            {label:'Account Name',fieldName:'Name',type:'text'},
            {label:'Account Description',fieldName:'Description',type:'text'}
        ];
        component.set('v.columns',col);
        var accAllRecords = component.get('c.AccRecords');
        accAllRecords.setCallback(this,function(response){
            var state = response.getState();
            if(state === 'SUCCESS'){
                var records = response.getReturnValue();
                console.log('@@@data '+records);
                component.set('v.data',records);
            }
        });
        $A.enqueueAction(accAllRecords);
	},
    handleClick : function(component, event, helper) {
		var name=component.get('v.Name');
        alert('@@@name'+name);
        console.log('@@@name'+name);
	},
    handleClickapex : function(component, event, helper) {
        var action =component.get("c.NameMethod");
        //action.SetParams({"n":"ddd","fff":"lll"});
        action.setCallback(this,function(response){
            var state=response.getState();
            console.log('@@@status '+state);
            if(state==='SUCCESS'){
            var value=response.getReturnValue();
                console.log('@@@value '+value);
            }
            
        });
        $A.enqueueAction(action);
    }

})