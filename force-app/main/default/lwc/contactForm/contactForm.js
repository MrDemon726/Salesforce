import { LightningElement, track, wire } from 'lwc';
import getFieldSet from '@salesforce/apex/ContactController.getFieldSet';
import checkPhoneAndIncreaseCounter from '@salesforce/apex/ContactController.checkPhoneAndIncreaseCounter';
import insertContact from '@salesforce/apex/ContactController.insertContact';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactForm extends LightningElement {
    @track fields = [];
    contactRecord = {};
    counter = 0;

    @wire(getFieldSet)
    wiredFields({ error, data }) {
        if (data) {
            this.fields = data;
        } else if (error) {
            console.error('Error fetching field set', error);
        }
    }

    handleChange(event) {
        const fieldName = event.target.dataset.name;
        this.contactRecord[fieldName] = event.target.value;

        if (fieldName === 'Phone') {
            this.checkPhoneNumber();
        }
    }

    checkPhoneNumber() {
        checkPhoneAndIncreaseCounter(this.contactRecord.Phone)
            .then(result => {
                this.counter = result;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Phone Matched!',
                        message: 'Number of Visits: ' + this.counter,
                        variant: 'success'
                    })
                );
            })
            .catch(error => {
                console.error('Error checking phone number', error);
            });
    }

    handleSubmit() {
        if (!this.contactRecord.Email || !this.contactRecord.Phone) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: 'Email and Phone are required.',
                    variant: 'error'
                })
            );
            return;
        }
        
        insertContact({ contactJson: JSON.stringify(this.contactRecord) })
            .then(result => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Result',
                        message: result,
                        variant: result.includes('already exists') ? 'error' : 'success'
                    })
                );
            })
            .catch(error => {
                console.error('Error inserting contact', error);
            });
    }
}