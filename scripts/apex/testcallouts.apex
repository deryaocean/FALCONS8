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



jsonString:
{
	"states": 56,
	"positive": 28756489,
	"negative": 74582825,
	"pending": 11808,
}

=> deserialize(jsonString, CovidWrapper.class);

public class CovidWrapper {
    public Integer states = 56;
    public Integer positive = 28756489;
    public Integer negative = 74582825;
    public Integer pending = 11808;
}

Covid_Info__c info = new Covid_Info__c();
info.positive__c = 

