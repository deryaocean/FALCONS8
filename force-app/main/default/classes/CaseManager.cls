@RestResource(urlMapping='/Case/*')
global with sharing class CaseManager {
    /* https://falcons8-dev-ed.my.salesforce.com/services/apexrest/Case/* */

    /* https://falcons8-dev-ed.my.salesforce.com/services/apexrest/Case/{caseId} */
    @HttpGet
    global static Case getCase() {        
        RestRequest request = RestContext.request;
        String requestUrl = request.requestURI;
        Integer lastIndex = requestUrl.lastIndexOf('/');
        Id caseId = requestUrl.subString(lastIndex+1);
        Case cs = [SELECT CaseNumber, Subject, Priority, Origin, Description FROM Case WHERE Id = :caseId LIMIT 1];
        return cs;
    }

    @HttpPost
    global static Id createCase(String subject, String priority, String origin, String description) {
        Case cs = new Case();
        cs.Subject = subject;
        cs.Priority = priority;
        cs.Origin = origin;
        cs.Description = description;
        insert cs;
        return cs.Id;
    }

    /* https://falcons8-dev-ed.my.salesforce.com/services/apexrest/Case/{caseId} */
    @HttpDelete
    global static String deleteCase() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        Integer lastIndex = uri.lastIndexOf('/');
        Id caseId = uri.subString(lastIndex+1);
        Case cs = [SELECT Id FROM Case where Id = :caseId LIMIT 1];
        delete cs;
        return 'Case has been deleted successfully!';
    }

    @HttpPut
    global static Id upsertCase(String id, String subject, String priority, String origin, String description) {
        Case cs = new Case();
        cs.Id = id;
        cs.Subject = subject; // cs.put('Subject', subject);
        cs.Priority = priority;
        cs.Origin = origin;
        cs.Description = description;
        upsert cs;
        return cs.Id;
    }

    @HttpPatch
    global static Case updateCase() {
        RestRequest request = RestContext.request;
        String jsonString = request.requestBody.toString();
        Map<String, Object> caseInfo = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        System.debug(caseInfo);
        Case cs = new Case();
        for(String key : caseInfo.keySet()) {
            cs.put(key, caseInfo.get(key));
        }
        update cs;
        return cs;
    }
}



/* https://falcons8-dev-ed.my.salesforce.com/services/apexrest/Case/5005h00000W7GUaAAN

//Approach 1
split('/') => ['https:', '', 'falcons8-dev-ed.my.salesforce.com', 'services', 'apexrest', 'Case', '5005h00000W7GUaAAN']
                0         1   2                                    3           4           5       6
                size = 7
                get the element from size-1 = 6 (7n)

//Approach 2
lastIndexOf('/') = 51 (1n)
51+1 = 52
requestUrl.subString(52) = 5005h00000W7GUaAAN
*/