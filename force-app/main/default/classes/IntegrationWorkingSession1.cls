public with sharing class IntegrationWorkingSession1 {
    
    public static HttpResponse getCovidCasesInfo() {
        //1. Prepare HttpRequest and wrap data in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://api.covidtracking.com/v1/us/current.json');
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet to receive response
        HttpResponse response = http.send(request);

        //4. process the response
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            List<CovidWrapper> wrappers = (List<CovidWrapper>)JSON.deserialize(jsonString, List<CovidWrapper>.class);
            CovidWrapper wrapper = wrappers[0];
            
            //check for existing records of today
            List<Covid_Info__c> infos = [SELECT Id, Name, Positive__c, Negative__c, Pending__c FROM Covid_Info__c WHERE Received_Date__c = TODAY];
            if(!infos.isEmpty()) {
                infos[0].Name = String.valueOf(wrapper.states);
                infos[0].Positive__c = wrapper.positive;
                infos[0].Negative__c = wrapper.negative;
                infos[0].Pending__c = wrapper.pending;
                update infos[0];
            } else {
                Covid_Info__c info = new Covid_Info__c();
                info.Name = String.valueOf(wrapper.states);
                info.Positive__c = wrapper.positive;
                info.Negative__c = wrapper.negative;
                info.Pending__c = wrapper.pending;
                info.Received_Date__c = Date.today();
                insert info;
            }
        }
        return response;
    }

    public static HttpResponse postPosts() {
        //1. Prepare HttpRequest and wrap data in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://gorest.co.in/public/v2/posts');
        request.setMethod('POST');

        //1.1 prepare body
        Posts__c posts = [SELECT User_ID__c, Title__c, Body__c FROM Posts__c WHERE CreatedDate = TODAY LIMIT 1];
        PostWrapper post = new PostWrapper();
        post.user_id = Integer.valueOf(posts.User_ID__c);
        post.title = posts.Title__c;
        post.body = posts.Body__c;
        request.setBody(JSON.serialize(post));
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization', 'Bearer 70e1f461fd475135683473e734663791d988ca49336b3a1002405be2ff00ed29');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the request over the internet to receive response
        HttpResponse response = http.send(request);

        //4. process the response
        if(response.getStatusCode() == 201) {
            System.debug(response.getBody());
        } else {
            System.debug('An error occurred while sending post!');
        }
        return response;
    }
}