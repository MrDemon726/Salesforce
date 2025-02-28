public with sharing class DynamicContactController {
    public class FieldSetWrapper {
        @AuraEnabled public String apiName;
        @AuraEnabled public String label;
        @AuraEnabled public String type;
        @AuraEnabled public Boolean required;

        public FieldSetWrapper(String apiName, String label, String type, Boolean required) {
            this.apiName = apiName;
            this.label = label;
            this.type = type;
            this.required = required;
        }
    }

    @AuraEnabled(cacheable=true)
    public static List<FieldSetWrapper> getContactFieldSet() {
        List<FieldSetWrapper> fieldSetList = new List<FieldSetWrapper>();
        Schema.FieldSet fieldSet = Schema.SObjectType.Contact.FieldSets.Dynamic_Fields;
        Map<String, Schema.SObjectField> contactFields = Schema.SObjectType.Contact.fields.getMap();

        for (Schema.FieldSetMember field : fieldSet.getFields()) {
            String fieldName = field.getFieldPath();
            Schema.DescribeFieldResult fieldDescribe = contactFields.get(fieldName).getDescribe();

            fieldSetList.add(new FieldSetWrapper(
                fieldName,
                field.getLabel(),
                fieldDescribe.getType().name(), // Get field type dynamically
                !fieldDescribe.isNillable() // If field is not nullable, it's required
            ));
        }
        
        return fieldSetList;
    }

    @AuraEnabled(cacheable=true)
    public static Contact getContactByPhone(String phone) {
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Email, Phone, Number_of_Visits__c, 
                                         Last_Visited_Date__c, Rating__c 
                                  FROM Contact WHERE Phone = :phone LIMIT 1];
        return contacts.isEmpty() ? null : contacts[0];
    }

    @AuraEnabled
    public static String saveContact(Contact contact) {
        List<Contact> existingContacts = [SELECT Id, Number_of_Visits__c, Last_Visited_Date__c 
                                          FROM Contact WHERE Phone = :contact.Phone LIMIT 1];

        if (!existingContacts.isEmpty()) {
            Contact existingContact = existingContacts[0];
            existingContact.Number_of_Visits__c += 1;
            existingContact.Last_Visited_Date__c = Date.today();
            update existingContact;
            return 'exists';
        } else {
            contact.Number_of_Visits__c = 1;
            contact.Last_Visited_Date__c = Date.today();
            insert contact;
            return 'new';
        }
    }
}