public with sharing class ContactCtrl {
    @AuraEnabled
    public static List<Contact> searchContacts(String searchKey) {
        searchKey = '%' + searchKey + '%';
        return [SELECT Name, Title, Email, Phone
                FROM Contact
                WHERE FirstName LIKE :searchKey
                OR LastName LIKE :searchKey
                WITH SECURITY_ENFORCED];
    }
}
