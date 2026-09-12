import { LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import { reduceErrors } from 'lightning/uiRecordApi';

const COLUMNS = [
    { label: 'First Name', fieldName: 'FirstName', type: 'text' },
    { label: 'Last Name', fieldName: 'LastName', type: 'text' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];

export default class ContactList extends LightningElement {
    columns = COLUMNS;
    contacts;
    error;

    // Cablear el método de Apex
    @wire(getContacts)
    wiredContacts({ error, data }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error; // Asignar el objeto de error completo
            this.contacts = undefined;
        }
    }

    /**
     * Definir un 'getter' para la propiedad 'errors'.
     * Utiliza la función reduceErrors para obtener una lista limpia de mensajes.
     * @return {String[]} Array de mensajes de error.
     */
    get errors() {
        return this.error ? reduceErrors(this.error) : [];
    }
}