//TEST ANIMALS CALLOUT//
HttpResponse resp = RestCallouts.getAnimals();
System.debug(resp);

//TEST USERS CALLOUT//
HttpResponse resp = RestCallouts.getUsers();
System.debug(resp);

//TEST PRODUCTS CALLOUT//
HttpResponse resp = RestCallouts.getProduct();
System.debug(resp);