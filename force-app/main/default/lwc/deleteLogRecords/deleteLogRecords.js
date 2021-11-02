import { LightningElement, track, api, wire} from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import LogType_FIELD from '@salesforce/schema/System_Log__c.Log_Level__c';
import { NavigationMixin } from 'lightning/navigation';
import deleteLogRecordsNow from '@salesforce/apex/SystemLogUtils.deleteLogRecords';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import getDeletes from '@salesforce/apex/SystemLogUtils.getDeleteLogs';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import System_Log__c from '@salesforce/schema/System_Log__c';

export default class MultiSelectCombobox extends NavigationMixin(LightningElement) {
    
    @api options;
    @api selectedValue;
    @api selectedValues = [];
    @api label ='Please Enter Details To Delete Log Records';
    @api minChar = 2;
    @api disabled = false;
    @api multiSelect = false;
    @api objectApiName;
    @track objectInfo;
    @track value;
    @track values = [];
    @track valuesRequired = [];
    @track optionData;
    @track searchString;
    @track message;
    @track showDropdown = false;
    @track showStart = false;
    @track end_date;
    @track start_date;
    @track sortBy;
    @track sortDirection;
    @track defaultSortDirection = 'dsc';
    @track columns = [
        { label: 'Apex Job Id', fieldName: 'Apex_Job_Id__c',sortable: "true"},
        { label: 'Start Date', fieldName: 'Start_Date__c',type: 'date', typeAttributes: {  
            day: '2-digit',  
            month: '2-digit',  
            year: 'numeric',  
            hour: '2-digit',  
            minute: '2-digit',  
            hour12: true},sortable: "true"},
        { label: 'End Date', fieldName: 'End_Date__c',type: 'date', typeAttributes: {  
            day: '2-digit',  
            month: '2-digit',  
            year: 'numeric',  
            hour: '2-digit',  
            minute: '2-digit',  
            hour12: true},sortable: "true"}, 
        { label: 'Log Level', fieldName: 'Log_Level__c',sortable: "true"},
        { label: 'Records Processed', fieldName: 'Records_Processed__c',sortable: "true"}
    ];
    @track deleteLogList;
   
    @wire (getDeletes) wiredAccounts({data,error}){
        if (data) {
             this.deleteLogList = data;
        } else if (error) {
        console.log(error);
        }
    }

    @wire(getObjectInfo, { objectApiName: System_Log__c })
    objectInfo;
    
    @wire(getPicklistValues, { 
        recordTypeId: "$objectInfo.data.defaultRecordTypeId" , fieldApiName: LogType_FIELD 
    })
    wiredPicklist({ error, data }){
        
        if(data){
            this.options = data.values;
            this.showDropdown = false;
            var optionData = this.options ? (JSON.parse(JSON.stringify(this.options))) : null;
            var value = this.selectedValue ? (JSON.parse(JSON.stringify(this.selectedValue))) : null;
            var values = this.selectedValues ? (JSON.parse(JSON.stringify(this.selectedValues))) : null;
            if(value || values) {
                var searchString;
                var count = 0;
                for(var i = 0; i < optionData.length; i++) {
                    if(this.multiSelect) {
                        if(values.includes(optionData[i].value)) {
                            optionData[i].selected = true;
                            count++;
                        }  
                    } else {
                        if(optionData[i].value == value) {
                            searchString = optionData[i].label;
                        }
                    }
                }
                if(this.multiSelect)
                    this.searchString = count + ' Option(s) Selected';
                else
                    this.searchString = searchString;
            }
            this.value = value;
            this.values = values;
            this.optionData = optionData;
        }
        if(error){
            this.optionData = undefined;
        }
    }

    doSorting(event) {
        this.sortBy = event.detail.fieldName;
        this.sortDirection = event.detail.sortDirection;
        this.sortData(this.sortBy, this.sortDirection);
    }

    sortData(fieldname, direction) {
        let parseData = JSON.parse(JSON.stringify(this.deleteLogList));
        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };
        // cheking reverse direction
        let isReverse = direction === 'asc' ? 1: -1;
        // sorting data
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';
            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });
        this.deleteLogList = parseData;
    }    

    filterOptions(event) {
        this.searchString = event.target.value;
        if( this.searchString && this.searchString.length > 0 ) {
            this.message = '';
            if(this.searchString.length >= this.minChar) {
                var flag = true;
                for(var i = 0; i < this.optionData.length; i++) {
                    if(this.optionData[i].label.toLowerCase().trim().startsWith(this.searchString.toLowerCase().trim())) {
                        this.optionData[i].isVisible = true;
                        flag = false;
                    } else {
                        this.optionData[i].isVisible = false;
                    }
                }
                if(flag) {
                    this.message = "No results found for '" + this.searchString + "'";
                }
            }
            this.showDropdown = true;
        } else {
            this.showDropdown = false;
        }
	}

    selectItem(event) {
        var selectedVal = event.currentTarget.dataset.id;
        if(selectedVal) {
            var count = 0;
            var options = JSON.parse(JSON.stringify(this.optionData));
            for(var i = 0; i < options.length; i++) {
                if(options[i].value === selectedVal) {
                    if(this.multiSelect) {
                        if(this.values.includes(options[i].value)) {
                            this.values.splice(this.values.indexOf(options[i].value), 1);
                        } else {
                            this.values.push(options[i].value);
                        }
                        options[i].selected = options[i].selected ? false : true;   
                    } else {
                        this.value = options[i].value;
                        this.searchString = options[i].label;
                    }
                }
                if(options[i].selected) {
                    count++;
                }
            }
            this.optionData = options;
            if(this.multiSelect)
                this.searchString = count + ' Option(s) Selected';
            if(this.multiSelect)
                event.preventDefault();
            else
                this.showDropdown = false;
        }
    }

    navigateToHomePage() {
        this[NavigationMixin.Navigate]({
            type: 'standard__navItemPage',
            attributes: {
                apiName: 'System_Logs_Tracker'
            },
        });
    }

    showOptions() {
        if(this.disabled == false && this.options) {
            this.message = '';
            this.searchString = '';
            var options = JSON.parse(JSON.stringify(this.optionData));
            for(var i = 0; i < options.length; i++) {
                options[i].isVisible = true;
            }
            if(options.length > 0) {
                this.showDropdown = true;
            }
            this.optionData = options;
        }
	}

    handleDateChange(event){
        let field_name = event.target.name;

        if(field_name === 'startdate'){
            this.start_date = event.target.value;
        } 
        if(field_name === 'enddate'){
            this.end_date = event.target.value; 
        }
        if(this.start_date !=undefined && this.end_date !=undefined){
            this.showStart = true;
        }
        if(this.start_date ==null || this.end_date ==null){
            this.showStart = false;
        }
    }

    deleteLogRecordsHandle(event){
        let loglevelvalues = this.values.toString();
        if(loglevelvalues =='' || loglevelvalues.includes("All")){
            var options = JSON.parse(JSON.stringify(this.optionData));
            for(var i = 0; i < options.length; i++) {
                if(options[i].value != 'All'){
                    this.valuesRequired.push(options[i].value);       
                }
            }
            loglevelvalues = this.valuesRequired.toString();  
        }
        let params ={startDate:this.start_date,endDate:this.end_date,logLevels:loglevelvalues};
        deleteLogRecordsNow(params)
        .then(result =>{
            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: ' Success',
                    message: 'Delete Batch Scheduled Successfully',
                    variant: 'success',
                }),
            );   
            setTimeout(function(){ 
                window.location.reload();
              }, 3000);          
           }
            
        )

        .catch(error => { console.log('errr--'+JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: ' Failed',
                    message: 'Contact Administrator',
                    variant: 'error',
                }),
            );
            
            })
    }

    blurEvent() {
        var previousLabel;
        var count = 0;
        for(var i = 0; i < this.optionData.length; i++) {
            if(this.optionData[i].value === this.value) {
                previousLabel = this.optionData[i].label;
            }
            if(this.optionData[i].selected) {
                count++;
            }
        }
        if(this.multiSelect)
        	this.searchString = count + ' Option(s) Selected';
        else
        	this.searchString = previousLabel;
        
        this.showDropdown = false;

        this.dispatchEvent(new CustomEvent('select', {
            detail: {
                'payloadType' : 'multi-select',
                'payload' : {
                    'value' : this.value,
                    'values' : this.values
                }
            }
        }));
    }
}