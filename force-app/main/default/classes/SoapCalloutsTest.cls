@isTest
public with sharing class SoapCalloutsTest {
    @isTest
    private static void parkServiceTest() {
        ParksServicesMock mock = new ParksServicesMock();
        Test.setMock(WebServiceMock.class, mock);
        String country = 'Turkey';
        String[] parks = SoapCallouts.getParksByCountry(country);
        System.assert(parks.size() != 0);
    }

    @isTest
    public static void getSumTest() {
        CalcServicesDoAddMock mock = new CalcServicesDoAddMock();
        Test.setMock(WebServiceMock.class, mock);
        Double output = SoapCallouts.getSum(5, 5);
        System.assertEquals(output, 10);
    }
}
