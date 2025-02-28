public with sharing class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Map<String, Object>> getFieldSet() {
        List<Map<String, Object>> fieldSetList = new List<Map<String, Object>>();
        for (Schema.FieldSetMember f : SObjectType.Contact.FieldSets.Dynamic_Fields.getFields()) {
            Map<String, Object> fieldMap = new Map<String, Object>();
            fieldMap.put('apiName', f.getFieldPath());
            fieldMap.put('label', f.getLabel());
            fieldMap.put('isRequired', f.getFieldPath() == 'Phone' || f.getFieldPath() == 'Email');
            fieldSetList.add(fieldMap);
        }
        return fieldSetList;
    }

    @AuraEnabled
    public static Decimal checkPhoneAndIncreaseCounter(String phoneNumber) {
        if (String.isEmpty(phoneNumber)) {
            throw new IllegalArgumentException('Phone number cannot be empty');
        }
        
        try {
            List<Contact> contacts = [SELECT Id, Phone, Number_of_Visits__c FROM Contact WHERE Phone = :phoneNumber LIMIT 1];
            if (!contacts.isEmpty()) {
                Contact con = contacts[0];
                con.Number_of_Visits__c = (con.Number_of_Visits__c == null) ? 1 : con.Number_of_Visits__c + 1;
                update con;
                return con.Number_of_Visits__c;
            }
        } catch (Exception e) {
            System.debug('Error in checkPhoneAndIncreaseCounter: ' + e.getMessage());
        }
        return 0;
    }

    @AuraEnabled
    public static String insertContact(String contactJson) {
        Map<String, Object> contactData = (Map<String, Object>) JSON.deserializeUntyped(contactJson);
        try {
            
            String phoneNumber = String.valueOf(contactData.get('Phone'));
            if (String.isEmpty(phoneNumber)) {
                return 'Phone number is required.';
            }
            List<Contact> existingContacts = [SELECT Id FROM Contact WHERE Phone = :phoneNumber LIMIT 1];
            if (!existingContacts.isEmpty()) {
                return 'Contact with this phone number already exists.';
            }
        } catch (Exception e) {
            return 'Error processing contact data: ' + e.getMessage();
        }
        
        Contact newContact = new Contact();
        for (String key : contactData.keySet()) {
            newContact.put(key, String.valueOf(contactData.get(key)));
        }
        insert newContact;
        return 'Contact created successfully.';
    }
}