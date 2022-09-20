///JSON///
//Account into JSON
{
    "Name" : "Universal Containers",
    "AnnualRevenue" : 2000000,
    "Industry" : "Biotechnology",
    "Type" : "New Customer"
}

//serialize method
Account acc = [SELECT Name, Type, Industry, AnnualRevenue FROM Account WHERE Name = 'United Oil & Gas Corp.' LIMIT 1];
String jsonString = JSON.serialize(acc);
System.debug(jsonString);

//Get an opportunity record whose amount is greater than 1M
//Convert that into json and debug it
Opportunity opp = [SELECT Name, Amount, StageName, Type FROM Opportunity WHERE Amount > 1000000 LIMIT 1];
String jsonString = JSON.serialize(opp);
System.debug(jsonString);

//Get a lead record whose email and phone are populated
//convert that record into json format and print it using debug
Lead ld = [SELECT FirstName, LastName, Email, Phone, Company FROM Lead WHERE Email != null AND Phone != null LIMIT 1];
String jsonString = JSON.serialize(ld);
System.debug(jsonString);

//I would like to send all leads whose Email & Company are populated as json
List<Lead> leads = [SELECT FirstName, LastName, Email, Company, Title
                    FROM Lead
                    WHERE Email != null
                    AND Company != null];
String jsonString = JSON.serialize(leads);
System.debug(jsonString);

//Get all opportunities (Name, Type, Amount, StageName) whose stagename is closed won
//convert them into json
List<Opportunity> opps = [SELECT Name, Type, Amount, StageName
                        FROM Opportunity
                        WHERE StageName = 'Closed Won'];
String jsonString = JSON.serialize(opps);
System.debug(jsonString);

//get 2 cases (CaseNumber, Subject, Description, Contact.FirstName, Contact.LastName, Account.Name) where subject is not null
//convert them into json format
List<Case> cases = [SELECT CaseNumber, Subject, Description, Contact.FirstName, Contact.LastName, Account.Name
                    FROM Case
                    WHERE Subject != null
                    LIMIT 2];
String jsonString = JSON.serialize(cases);
System.debug(jsonString);