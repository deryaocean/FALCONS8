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

    public static HttpResponse getBlogs() {
        //1. Prepare HttpRequest & wrap the necessary information in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://mockyard.herokuapp.com/blogs/2');
        request.setMethod('GET');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the HttpRequest over the internet to receive HttpResponse back
        HttpResponse response = http.send(request);

        //4. Process the HttpResponse
        if(response.getStatusCode() == 200) {
            //jsonString => wrappers => blog records
            String jsonString = response.getBody();
            System.debug(jsonString);

            List<BlogWrapper> blogWrappers = (List<BlogWrapper>)JSON.deserialize(jsonString, List<BlogWrapper>.class);
            List<Blog__c> blogs = new List<Blog__c>();
            for(BlogWrapper bw : blogWrappers) {
                Blog__c blog = new Blog__c();
                blog.Topic__c = bw.topic;
                blog.Author__c = bw.author;
                blog.Body__c = bw.body;
                blog.Title__c = bw.title;
                blogs.add(blog);
            }
            try {
                if(!blogs.isEmpty()) {
                    insert blogs;
                }
            } catch(Exception ex) {
                //Create a log record
                CommonUtility.createLog('RestCallouts - getblogs', 'Integration Apex', ex.getStackTraceString(), 'Exception', ex.getTypeName(), ex.getMessage(), '');
            }
        }
        return response;
    }

        public static HttpResponse postCallout() {
            //1. Prepare HttpRequest & wrap the necessary information in it
            HttpRequest request = new HttpRequest();
            // They are expecting a name.
            /*e.g.{
                'name':'{'FirstName':'Sri'}',
                'Age':'30',
                'Role':'Saelsforce Consultant'
            }*/
            request.setMethod('POST');
            request.setEndPoint('https://th-apex-http-callout.herokuapp.com/animals');
            request.setHeader('Content-Type', 'application/json;charset=UTF-8');
            Map<String,Object> input = new Map<String,Object>();
            input.put('name','cat');
            request.setBody(JSON.serialize(input));
            //In this example.
            //'{'name':'Cat'}'
            //2. Prepare internet
            Http http = new Http();
            //3. Send the HttpRequest over the internet to receive HttpResponse back
            HttpResponse response = http.send(request);
            //4. Process the HttpResponse
            if(response.getStatusCode()==201){
                system.debug(response.getBody());
            }
            else{
                system.debug(response.getStatus());
            }
            return response;
        }

    public static HttpResponse postContacts() {
        //1. Prepare HttpRequest & wrap the necessary information in it
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://gorest.co.in/public/v2/users');
        request.setMethod('POST');

        //1.1 Get data and prepare it as JSON
        List<Contact> contacts = [SELECT Name, Email, Gender__c, Status__c 
                                    FROM Contact
                                    WHERE Gender__c != null
                                    AND Status__c != null
                                    LIMIT 1];
        ContactWrapper cw = new ContactWrapper();
        for(Contact con : contacts) {            
            cw.name = con.Name;
            cw.email = con.Email;
            cw.gender = con.Gender__c;
            cw.status = con.Status__c;
        }
        request.setBody(JSON.serialize(cw));
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setHeader('Authorization', 'Bearer 70e1f461fd475135683473e734663791d988ca49336b3a1002405be2ff00ed29');

        //2. Prepare internet
        Http http = new Http();

        //3. Send the HttpRequest over the internet to receive HttpResponse back
        HttpResponse response = http.send(request);
        System.debug(response.getBody());
        //4. Process the HttpResponse
        if(response.getStatusCode() == 201) {
            System.debug('Request has been processed successfully');
        }
        return response;
    }
}