@isTest
public with sharing class ContactManagerTest {
    @TestSetup
    static void makeData(){
        //create account
        Account acc = new Account(Name='TestAccount');
        insert acc;

        //create 4 contacts
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0; i<4; i++) {
            Contact con = new Contact();
            con.FirstName = 'FirstName ' + i;
            con.LastName = 'LastName ' + i;
            con.Email = 'test@test.com';
            con.Title = 'Salesforce Consultant';
            con.Department = 'IT';
            contacts.add(con);
        }
        insert contacts;
    }

    @isTest
    private static void getContactTest() {
        //prepare request uri
        Contact con = [SELECT Id FROM Contact LIMIT 1];
        String homeUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        String uri = homeUrl + '/services/apexrest/' + con.Id;

        //prepare RestRequest & Context
        RestRequest request = new RestRequest();
        request.requestURI = uri;
        request.httpMethod = 'GET';
        RestContext.request = request;

        //Test the method
        Contact newCon = ContactManager.getContact();
        System.assert(newCon.Id != null);
    }

    @isTest
    private static void createContactTest() {
        Id contactId = ContactManager.createContact('FirstName', 'LastName', 'Consultant', 'test@test.com', 'IT');
        System.assert(contactId != null);
    }

    @isTest
    private static void deleteContactTest() {
        //prepare request uri
        Contact con = [SELECT Id FROM Contact LIMIT 1];
        String homeUrl = System.URL.getSalesforceBaseUrl().toExternalForm();
        String uri = homeUrl + '/services/apexrest/' + con.Id;

        //prepare RestRequest & Context
        RestRequest request = new RestRequest();
        request.requestURI = uri;
        request.httpMethod = 'GET';
        RestContext.request = request;

        //Test the method
        String actual = ContactManager.deleteContact();
        System.assertEquals(actual, 'Contact has been deleted successfully!');
    }

    @isTest
    private static void upsertContactTest() {
        Id contactId = ContactManager.upsertContact(null, 'FirstName', 'LastName', 'Consultant', 'test@test.com', 'IT');
        System.assert(contactId != null);
    }

    @isTest
    private static void updateContactTest() {
        //prepare request body
        Contact con = [SELECT Id, FirstName, LastName, Email, Title, Department FROM Contact LIMIT 1];
        con.Description = 'This is from test claass';
        String jsonString = JSON.serialize(con);

        //prepare RestRequest & Context
        RestRequest request = new RestRequest();
        request.requestBody = Blob.valueOf(jsonString);
        request.httpMethod = 'PATCH';
        RestContext.request = request;

        //Test the method
        Contact newCon = ContactManager.updateContact();
        System.assertEquals(newCon.Description, 'This is from test claass');
    }
}
