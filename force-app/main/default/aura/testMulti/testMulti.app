<aura:application extends="force:slds">
    <aura:attribute name="options" type="List" default="[{'label':'Bob','value':'123'},
                                                         {'label':'Chrissey','value':'345'},
                                                         {'label':'Jessica','value':'456','disabled': true},
                                                         {'label':'Sunny','value':'567'}]" />
    <aura:attribute name="selectedValues" type="List" default="" description="Selected value in Multi Select" />
 	
    <c:deleteLogRecords multiSelect="true" options="{!v.options}" selectedValues="{!v.selectedValues}"></c:deleteLogRecords>
</aura:application>