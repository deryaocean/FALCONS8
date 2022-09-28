@isTest
public with sharing class CaseManagerTest {
    @TestSetup
    static void makedata() {
        //create an account, a contact and 4 cases
        Account acc = new Account(Name='Test Account');
        insert acc;
        Contact con = new Contact(FirstName='Integration', LastName='Test', Email='test@test.com');
        insert con;

        List<Case> cases = new List<Case>();
        for(Integer i=0; i<4; i++) {
            Case cs = new Case();
            cs.AccountId = acc.Id;
            cs.ContactId = con.Id;
            cs.Subject = 'Problem with the Wi-Fi Routor ' + i;
            cs.Description = 'There was a problem with my Wi-Fi routor since morning. I do not get data';
            cs.Origin = 'Email';
            cs.Priority = 'Medium';
            cases.add(cs);
        }
        insert cases;
    }

    @isTest
    private static void getCaseTest() {
        //prepare request uri
        Case cs = [SELECT Id, CaseNumber, Subject, Description, Priority, Origin FROM Case LIMIT 1];
        String homeUrl = System.URL.getSalesforceBaseUrl().toExternalForm(); //Base URL
        String uri = homeUrl + '/services/apexrest/Case/' + cs.Id;

        //prepare restrequest and context
        RestRequest request = new RestRequest();
        request.requestURI = uri;
        request.httpMethod = 'GET';
        RestContext.request = request;

        //test the method and perform asserts
        Case objCase = CaseManager.getCase();
        System.assert(objCase.Id != null);
        System.assertEquals(objCase.Subject, cs.Subject);
        System.assertEquals(objCase.CaseNumber, cs.CaseNumber);
    }
}
