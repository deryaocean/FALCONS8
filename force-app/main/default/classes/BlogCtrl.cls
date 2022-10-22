public with sharing class BlogCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Blog__c> getAllBlogs() {
        return [SELECT Name, Author__c, Topic__c, Title__c, Body__c
                FROM Blog__c
                WITH SECURITY_ENFORCED];
    }
}
