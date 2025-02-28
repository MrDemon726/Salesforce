import { LightningElement, track } from 'lwc';

export default class VerticalProgressBar extends LightningElement {
    @track progressValue = 100; // Default progress value

    // Change checkmark color dynamically based on progress
    get checkStyle() {
        return `background-color: ${this.progressValue >= 100 ? 'green' : 'gray'}; color: white;`;
    }
}