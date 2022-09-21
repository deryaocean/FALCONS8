public with sharing class RestCallouts {
    
    public static HttpResponse getAnimals() {
        //1. Prepare HttpRequest & wrap the necessary information in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals');
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the HttpRequest over the internet to receive HttpResponse back
        HttpResponse response = http.send(request);

        //4. Process the HttpResponse
        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
        } else {
            //Create a log record
            CommonUtility.createLog('RestCallouts - getAnimals', 'Integration Apex', '', 'Error', 'Callout Exception', response.getStatus(), response.getBody());
        }
        return response;
    }

    public static HttpResponse getUsers() {
        //1. Prepare HttpRequest & wrap the necessary information in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://gorest.co.in/public/v2/users');
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the HttpRequest over the internet to receive HttpResponse back
        HttpResponse response = http.send(request);

        //4. Process the HttpResponse
        if(response.getStatusCode() == 200) {
            System.debug(response.getBody());
        } else {
            //Create a log record
            CommonUtility.createLog('RestCallouts - getUsers', 'Integration Apex', '', 'Error', 'Callout Exception', response.getStatus(), response.getBody());
        }
        return response;
    }

    //https://api.spoonacular.com/recipes/random?apiKey=33856f4dd2aa447997e50b85f8128a7b

    //https://mockyard.herokuapp.com/products/1
    public static HttpResponse getProduct() {
        //1. Prepare HttpRequest & wrap the necessary information in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://mockyard.herokuapp.com/products/1');
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the HttpRequest over the internet to receive HttpResponse back
        HttpResponse response = http.send(request);

        //4. Process the HttpResponse
        if(response.getStatusCode() == 200) {
            String jsonString = response.getBody();
            System.debug(jsonString);
            //convert the json string into our product object
            List<ProductWrapper> productWrappers = (List<ProductWrapper>)JSON.deserialize(jsonString, List<ProductWrapper>.class);
            List<Product__c> products = new List<Product__c>();
            for(ProductWrapper pw : productWrappers) {
                Product__c prod = new Product__c();
                prod.Name = pw.productId;
                prod.Category__c = pw.category;
                prod.Description__c = pw.description;
                String pr = pw.price.subString(1); //$23.01
                prod.Price__c = Decimal.valueOf(pr);
                prod.Image__c = pw.image;
                prod.Product_Name__c = pw.name;
                products.add(prod);
            }
            try {
                if(!products.isEmpty()) {
                    insert products;
                }
            } catch(Exception ex) {
                //Create a log record
                CommonUtility.createLog('RestCallouts - getProduct', 'Integration Apex', ex.getStackTraceString(), 'Exception', ex.getTypeName(), ex.getMessage(), '');
            }
        }
        return response;
    }
}
