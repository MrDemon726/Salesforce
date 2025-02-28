import { LightningElement, track, wire, api } from 'lwc';
import getContactFieldSet from '@salesforce/apex/DynamicContactController.getContactFieldSet';
import getContactByPhone from '@salesforce/apex/DynamicContactController.getContactByPhone';
import saveContact from '@salesforce/apex/DynamicContactController.saveContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class dyanmicContactForm extends LightningElement {
    @api title = 'dyanmicContactForm';
    @track fields = [];
    @track fieldValues = {}; 
    rating = 0;
    disabledFields = ['Number_of_Visits__c', 'Last_Visited_Date__c'];

    @wire(getContactFieldSet)
    wiredFields({ data, error }) {
        if (data) {
            this.fields = data.map(f => ({
                ...f,
                type: f.type.toLowerCase() === 'email' ? 'email' : f.type.toLowerCase() === 'phone' ? 'tel' : 'text',
                disabled: this.disabledFields.includes(f.apiName),
                value: this.fieldValues[f.apiName] || '' // Precompute value directly
            }));
        } else if (error) console.error('Error fetching fields:', error);
    }

    handleChange(event) {
        this.fieldValues = { ...this.fieldValues, [event.target.name]: event.target.value };
        this.updateFieldValues();
    }

    updateFieldValues() {
        this.fields = this.fields.map(f => ({ ...f, value: this.fieldValues[f.apiName] || '' }));
    }

    handleRating(event) {
        this.rating = event.target.dataset.value;
        this.fieldValues.Rating__c = this.rating;
        this.updateFieldValues();
        this.template.querySelectorAll('.star').forEach(star => {
            star.classList.toggle('active', star.dataset.value <= this.rating);
        });
    }

    handleSubmit() {
        const { Phone, Email } = this.fieldValues;
        if (!Phone || !/^\d{10}$/.test(Phone)) return this.showToast('Error', 'Invalid phone number. Must be 10 digits.', 'error');
        if (!Email || !/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(Email)) return this.showToast('Error', 'Invalid email format.', 'error');

        getContactByPhone({ phone: Phone }).then(existingContact => {
            if (existingContact) {
                existingContact.Number_of_Visits__c += 1;
                existingContact.Last_Visited_Date__c = new Date().toISOString().split('T')[0];
                this.fieldValues = { ...existingContact };
                this.updateFieldValues();
                this.showToast('Info', 'Contact exists. Number of visits updated.', 'info');
            } else return saveContact({ contact: this.fieldValues });
        }).then(result => {
            if (result === 'new') {
                this.showToast('Success', 'New contact created.', 'success');
                this.fieldValues = {};
                this.updateFieldValues();
            }
        }).catch(error => this.showToast('Error', 'Something went wrong: ' + error.body.message, 'error'));
    }

    showToast(title, message, variant) {
        this.dispatchEvent(new ShowToastEvent({ title, message, variant }));
    }
}