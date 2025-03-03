//Adding to the new branch//

public with sharing class GoogleSheetApi {

    @AuraEnabled(cacheable=true)
    public static String appendRowsByIds(List<String> contactIds) {
        if (contactIds == null || contactIds.isEmpty()) {
            return 'No contact IDs provided';
        }

        List<Contact> contacts = [SELECT Id, FirstName, LastName FROM Contact WHERE Id IN :contactIds];
        if (contacts.isEmpty()) {
            return 'No contacts found';
        }

        String returnBody;
        HttpRequest req = new HttpRequest();
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type', 'application/json');
        req.setMethod('POST');

        // Define the endpoint (same for single and multiple contacts)
        String endpoint = 'callout:Google_Sheet_Integration/v4/spreadsheets/1J5N39LdJ0n__W983HEp9cjOu-KpCFLcT_glKd5V7Ad8/values/Sheet1:append?valueInputOption=RAW';
        req.setEndpoint(endpoint);

        // Construct JSON body for multiple contacts
        String jsonString = '{"majorDimension": "ROWS","values": [';
        List<String> rowValues = new List<String>();
        for (Contact c : contacts) {
            rowValues.add('["' + c.FirstName + '", "' + c.LastName + '"]');
        }
        jsonString += String.join(rowValues, ',') + '], "range": "Sheet1"}';

        System.debug('Json Request Body: ' + jsonString);
        req.setBody(jsonString);

        Http https = new Http();
        HttpResponse res = https.send(req);
        System.debug('Json Response Body: ' + res.getBody());

        if (res.getStatusCode() == 200) {
            System.debug('Request succeeded');
            returnBody = 'Successfully synced ' + contacts.size() + ' contacts';
        } else {
            System.debug('Sync failed');
            returnBody = 'Sync Failed: ' + res.getBody();
        }

        return returnBody;
    }
}