import { LightningElement, track, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import sendAppDetail from '@salesforce/apex/saveApp.getAppDetail';


export default class ApplicationForm extends LightningElement {

    @track selectedStep = 'Step1';
    @track Year;
    @track Course;
    @track FirstName;
    @track MiddleName;
    @track LastName;
    @track PrimaryContact;
    @track AddressLine1;
    @track AddressLine2;
    @track ExamDetail;
    @track Result;
    @track Percentage;
    @track AddDetail;
    @track Blood;
    @track isSuccess =false;

    @track options = [
        { label: 'Computer Science', value: 'Computer Science' },
        { label: 'Electronics ', value: 'Electronics' }    
    ];   
    @track options1 = [
        { label: '1', value: '1' },
        { label: '2', value: '2' },
        { label: '3', value: '3' }
    ];   
    @track options2 = [
        { label: 'Pass', value: 'Pass' },
        { label: 'Failed', value: 'Failed' },
    ];   
    @track value;
 
    handleNext() {
        var getselectedStep = this.selectedStep;
        if(getselectedStep === 'Step1'){
            this.selectedStep = 'Step2';
        }
    }

    handleChange3(event) {
        this.progress = event.target.value;
    }
    handleChange4(event) {
        this.progress1 = event.target.value;
    }
    handlePrev() {
        var getselectedStep = this.selectedStep;
        if(getselectedStep === 'Step2'){
            this.selectedStep = 'Step1';
            
        }
    }
    

    handleValues(event) {
        const fieldName = event.target.name;
        if(fieldName =='input1'){
            this.FirstName = event.target.value;
        }
        else if(fieldName =='input2'){
        this.MiddleName = event.target.value;
        }
        else if(fieldName =='input3'){
        this.LastName = event.target.value;
        }
        else if(fieldName =='input4'){
        this.PrimaryContact = event.target.value;
        }
        else if(fieldName =='input5'){
        this.AddressLine1 = event.target.value;
        }
        else if(fieldName =='input6'){
        this.AddressLine2 = event.target.value;
        }
        else if(fieldName =='input7'){
        this.ExamDetail = event.target.value;
        }
        else if(fieldName =='input8'){
            this.Result = event.target.value;
        }
        else if(fieldName =='input9'){
            this.Percentage = event.target.value;
        }
        else if(fieldName =='input10'){
        this.Course = event.target.value;
        }
        else if(fieldName =='input11'){
            this.Year = event.target.value;
        }
        else if(fieldName =='input12'){
            this.AddDetail = event.target.value;
        }
        else if(fieldName =='input13'){
            this.Blood = event.target.value;
        }

    }
    
    

    handleFinish(event) {
        const paraValues = this.FirstName +','+this.MiddleName +','+this.LastName +','+this.PrimaryContact +','
        +this.AddressLine1 +','+this.AddressLine2 +','+this.ExamDetail +','+this.Result +','+this.Percentage +','
        +this.Course +','+this.Year +','+this.AddDetail +','+this.Blood;
        console.log('paraValues 1-'+paraValues);
        console.log('value 1-'+this.MiddleName);
        console.log('value 2-'+this.FirstName);
        console.log('value 3-'+this.LastName);
        console.log('value 4-'+this.PrimaryContact);
        console.log('value 5-'+this.AddressLine1);
        console.log('value 6-'+this.AddressLine2);
        console.log('value 7-'+this.Blood);
        this.selectedStep = 'Step1';
        let params ={appDetail:paraValues};

        sendAppDetail(params)
        .then(result =>{
            
            this.dispatchEvent(
                new ShowToastEvent({
                    title: ' Success',
                    message: 'Application Sent Successfully',
                    variant: 'success',
                }),
            );

            this.isSuccess = true;
            
           }
            
            )

        .catch(error => {
            console.log('error--'+JSON.stringify(error));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: ' Failed',
                    message: 'Contact Administrator',
                    variant: 'error',
                }),
            );
            
            })
    }
      
    selectStep1() {
        this.selectedStep = 'Step1';
    }
 
    selectStep2() {
        this.selectedStep = 'Step2';
    }
 
    get isSelectStep2() {
        return this.selectedStep === "Step2";
    }

    get isSelectStepPage1() {
        return this.selectedStep === "Step1";
    }
 
    

}