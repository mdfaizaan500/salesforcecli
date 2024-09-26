({
	myActionCallApex : function(component, event, helper) {
       
        var colm =[
            {label:'ActName', fieldName:'Name', type:'text'},
            {label:'DescriptionAccount', fieldName:'Description', type:'text'}
        ];
        component.set('v.columns',colm);
        
        var accountrecords = component.get('c.Getrecords');
        accountrecords.setCallback(this,function(response){
            var state = response.getState();
             console.log('@@@state'+state);
            if(state === 'SUCCESS'){
                var records1 = response.getReturnValue();
                console.log('@@@records'+records1);
                component.set('v.data',records1);
            }
            
        });
         $A.enqueueAction(accountrecords);
	}
})