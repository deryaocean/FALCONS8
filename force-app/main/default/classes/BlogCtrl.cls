public with sharing class BlogCtrl {
    @AuraEnabled(cacheable=true)
    public static List<Blog__c> getAllBlogs() {
        return [SELECT Name, Author__c, Topic__c, Title__c, Body__c
                FROM Blog__c
                WITH SECURITY_ENFORCED];
    }

    /*
    *    1. Get all the topic names from blog records - apex1
    *    2. Refine them just to have unique topic names - apex1
    */
    @AuraEnabled(cacheable=true)
    
}
