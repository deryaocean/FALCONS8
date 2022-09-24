//TEST ANIMALS CALLOUT//
HttpResponse resp = RestCallouts.getAnimals();
System.debug(resp);

//TEST USERS CALLOUT//
HttpResponse resp = RestCallouts.getUsers();
System.debug(resp);

//TEST PRODUCTS CALLOUT//
HttpResponse resp = RestCallouts.getProduct();
System.debug(resp);

//TEST BLOGS CALLOUT//
HttpResponse resp = RestCallouts.getBlogs();
System.debug(resp);

//TEST POST USERS//
HttpResponse resp = RestCallouts.postContacts();
System.debug(resp);

//TEST COVID CALLOUT//
HttpResponse resp = IntegrationWorkingSession1.getCovidCasesInfo();
System.debug(resp);

//TEST POST CALLOUT//
HttpResponse resp = IntegrationWorkingSession1.postPosts();
System.debug(resp);

//TEST PARKS CALLOUT//
String[] parks = SoapCallouts.getParksByCountry('Singapore');
System.debug(parks);

//TEST CALCULATOR CALLOUTS//
Double sum = SoapCallouts.getSum(10, 20);
System.debug(sum);

Double sum = SoapCallouts.getMultiply(10, 20);
System.debug(sum);

Double sum = SoapCallouts.getSubtract(10, 20);
System.debug(sum);

Double sum = SoapCallouts.getDivide(10, 20);
System.debug(sum);