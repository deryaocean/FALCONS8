@RestResource(urlMapping='/Contact/*')
global with sharing class ContactManager {
    //https://falcons8-dev-ed.my.salesforce.com/services/apexrest/Contact/0035h00000kJTr8AAG
    @HttpGet
    global static Contact getContact() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        Integer pos = uri.lastIndexOf('/');
        Id contactId = uri.subString(pos+1);
        Contact con = [SELECT FirstName, LastName, Title, Email, Department FROM Contact WHERE Id = :contactId];
        return con;
    }

    @HttpPost 
    global static Id createContact(String FirstName, String LastName, String Title, String Email, String Department) {
        Contact con = new Contact();
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Title = Title;
        con.Email = Email;
        con.Department = Department;
        insert con;
        return con.Id;
    }

    @HttpDelete
    global static String deleteContact() {
        RestRequest request = RestContext.request;
        String uri = request.requestURI;
        Integer pos = uri.lastIndexOf('/');
        Id contactId = uri.subString(pos+1);
        Contact con = [SELECT Id FROM Contact WHERE Id = :contactId];
        delete con;
        return 'Contact has been deleted successfully!';
    }

    @HttpPut 
    global static Id upsertContact(String Id, String FirstName, String LastName, String Title, String Email, String Department) {
        Contact con = new Contact();
        con.Id = Id;
        con.FirstName = FirstName;
        con.LastName = LastName;
        con.Title = Title;
        con.Email = Email;
        con.Department = Department;
        upsert con;
        return con.Id;
    }

    @HttpPatch
    global static Contact updateContact() {
        RestRequest request = RestContext.request;
        String jsonString = request.requestBody.toString();
        Map<String, Object> info = (Map<String, Object>)JSON.deserializeUntyped(jsonString);
        Contact con = new Contact();
        for(String field : info.keySet()) {
            if(field != 'attributes') {
                con.put(field, info.get(field));
            }            
        }
        update con;
        return con;
    }
}
