@isTest
global class OpportunityServiceTest {
    static Account account;
    static Opportunity opportunity;
    static Opportunity invalidAddressOpportunity;

    @TestSetup
    public static void setUpTestEnv() {
        TriggerHandler.bypassOpportunityTrigger = true;
        account = new Account();
        account.Name = 'Test Account';
        insert account;

        opportunity = new Opportunity();
        opportunity.Name = 'Test Opportunity';
        opportunity.StageName = 'Closed Won';
        opportunity.AccountId = account.Id;
        opportunity.CloseDate = Date.today().addDays(30);
        opportunity.Adresse__City__s = 'Paris';
        opportunity.Adresse__PostalCode__s = '75017';
        opportunity.Adresse__CountryCode__s = 'FR';
        opportunity.Adresse__Street__s = '10 rue Dulong';
        opportunity.latitude__c = '48.866667';
        opportunity.longitude__c = '2.333333';
        insert(opportunity);

        invalidAddressOpportunity = new Opportunity();
        invalidAddressOpportunity.Name = 'Invalid Address Opportunity';
        invalidAddressOpportunity.StageName = 'Closed Won';
        invalidAddressOpportunity.AccountId = account.Id;
        invalidAddressOpportunity.CloseDate = Date.today().addDays(30);
        invalidAddressOpportunity.Adresse__City__s = 'aaaaaaaaaa';
        invalidAddressOpportunity.Adresse__PostalCode__s = '000000000000';
        invalidAddressOpportunity.Adresse__CountryCode__s = 'FR';
        invalidAddressOpportunity.Adresse__Street__s = 'bbbbbbbbbbbbb';
        insert(invalidAddressOpportunity);

    }

    @isTest
    static void testGetOpportunitiesWithAccount() {
        Test.startTest();
            String jsonOpp = OpportunityService.getOpportunitiesWithAccount();
        Test.stopTest();

        List<Opportunity> oppList = (List<Opportunity>) JSON.deserialize(jsonOpp, List<Opportunity>.class);

        System.assertNotEquals(jsonOpp, '[]', 'testGetOpportunitiesWithAccount : an opportunity should have been added');
        System.assert(oppList.size() > 0, 'testGetOpportunitiesWithAccount: there should be at least one opportunity');
        System.assertEquals('Test Opportunity', oppList[0].Name, 'testGetOpportunitiesWithAccount: The opportunity name should be "Test Opportunity"');
        System.assertEquals('Closed Won', oppList[0].StageName, 'testGetOpportunitiesWithAccount: the stage name should be "Closed Won"');
    }

    @isTest
    static void testGetOpportunity() {
        Opportunity opp = [
                SELECT
                    Id,
                    Name
                FROM
                    Opportunity
                WHERE
                    Name = 'Test Opportunity'
            ];

        Test.startTest();    
            String jsonOpp = OpportunityService.getOpportunity(opp.Id);
        Test.stopTest();

        List<Opportunity> oppList = (List<Opportunity>) JSON.deserialize(jsonOpp, List<Opportunity>.class);

        System.assertNotEquals(jsonOpp, '[]', 'testGetOpportunity : an opportunity should have been added');
        System.assertEquals('Test Opportunity', oppList[0].Name, 'testGetOpportunity: The opportunity name should be "Test Opportunity"');
    }

    @isTest
    static void testGetUrlParamsAllParams() {
        String expected = '&city=San+Francisco&country=USA&street=123+Main+St&postalCode=94105&state=CA';
        String actual = OpportunityService.getUrlParams('San Francisco', 'USA', '123 Main St', '94105', 'CA');

        System.assertEquals(expected, actual, 'testGetUrlParamsAllParams: URL parameters should match the expected value');
    }

    @isTest
    static void testGetUrlParamsSomeParams() {
        String expected = '&city=San+Francisco&country=USA';
        String actual = OpportunityService.getUrlParams('San Francisco', 'USA', null, null, null);

        System.assertEquals(expected, actual, 'testGetUrlParamsSomeParams: URL parameters should match the expected value');
    }

    @isTest
    static void testGetUrlParamsNoParams() {
        String expected = '';
        String actual = OpportunityService.getUrlParams(null, null, null, null, null);

        System.assertEquals(expected, actual, 'testGetUrlParamsNoParams: URL parameters should be empty');
    }

    @isTest
    static void testGetUrlParamsSpecialCharacters() {
        String expected = '&city=San+Francisco&country=U%26A&street=123+Main+St+%26+Second+St&postalCode=94105&state=C%23A';
        String actual = OpportunityService.getUrlParams('San Francisco', 'U&A', '123 Main St & Second St', '94105', 'C#A');

        System.assertEquals(expected, actual, 'testGetUrlParamsSpecialCharacters: URL parameters should be correctly URL encoded');
    }

    @isTest
    static void testFetchOpportunityCoordsValidAddress() {
        Test.setMock(HttpCalloutMock.class, new MockHttpOpenStreetMapResponse());

        Opportunity opp = [
            SELECT
                Id,
                Adresse__c
            FROM
                Opportunity
            WHERE
                Name = 'Test Opportunity'
        ];

        Test.startTest();
            OpportunityService.fetchOpportunityCoords(opp.Id);
        Test.stopTest();

        Opportunity updatedOpportunity = [SELECT latitude__c, longitude__c FROM Opportunity WHERE Id = :opp.Id];
        System.assertEquals('48.866667', updatedOpportunity.latitude__c, 'Latitude should be updated');
        System.assertEquals('2.333333', updatedOpportunity.longitude__c, 'Longitude should be updated');
    }

    @isTest
    static void testFetchOpportunityCoordsInvalidAddress() {
        Test.setMock(HttpCalloutMock.class, new MockHttpOpenStreetMapResponse());

        Opportunity invalidAddressOpp = [
            SELECT
                Id,
                Adresse__c
            FROM
                Opportunity
            WHERE
                Name = 'Invalid Address Opportunity'
        ];

        Test.startTest();
            OpportunityService.fetchOpportunityCoords(invalidAddressOpp.Id);
        Test.stopTest();

        Opportunity updatedOpportunity = [SELECT latitude__c, longitude__c FROM Opportunity WHERE Id = :invalidAddressOpp.Id];

        System.assertEquals(null, updatedOpportunity.latitude__c, 'testFetchOpportunityCoordsInvalidAddress: Latitude should not be updated');
        System.assertEquals(null, updatedOpportunity.longitude__c, 'testFetchOpportunityCoordsInvalidAddress: longitude should not be updated');
    }

}