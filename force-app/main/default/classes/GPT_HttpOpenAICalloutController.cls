public with sharing class GPT_HttpOpenAICalloutController {

    private static String CHAT_GPT_KEY = GPT_ChatGPTConfigurations__c.getOrgDefaults().SecretKey__c;
    private static final String ENDPOINT = GPT_ChatGPTConfigurations__c.getOrgDefaults().Endpoint__c;
    
    @AuraEnabled
    public static String getAIResponse(String strSearchString) {
        try{
            String strSeachQueryEscaped = (strSearchString).trim();
            Http http = new Http();
            String reqBody = '{"model": "text-davinci-003","prompt":"'
                +strSeachQueryEscaped+
                '","max_tokens": 4000,"temperature": 0,'
                +'"stream": false,"top_p": 0.5}';
            System.debug('Query '+strSeachQueryEscaped+' '+reqBody);
            HttpRequest request = new HttpRequest();
            request.setEndpoint(ENDPOINT);
            request.setMethod('POST');
            request.setHeader('Authorization', 'Bearer '+String.escapeSingleQuotes(CHAT_GPT_KEY).trim());
            //Setting timeout to max 120 second to get whole response from Chat GPT Open API
            request.setTimeout(120000);
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            // Set the body as a JSON object
            request.setBody(reqBody);
            HttpResponse response = http.send(request);
            system.debug('response :: '+response.getBody());
            // Parse the JSON response
            if(response.getStatusCode() != 200) {
                System.debug('The status code returned was not expected: ' + response.getStatusCode() + ' ' + response.getBody());
                return response.getBody();
            }
            return response.getBody();
        }catch(Exception ex){
            System.debug('Exception in Catch of Server-Side Controller '+ex);
            throw new AuraHandledException(ex.getMessage());
        }
    }
}