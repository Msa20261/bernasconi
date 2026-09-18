@IsTest
public class OpportunityQueueableTest {

    @TestSetup
    static void setupTestData() {
        OpportunityServiceTest.setUpTestEnv();
    }

    @IsTest
    static void testOpportunityQueueable() {
        Test.setMock(HttpCalloutMock.class, new MockHttpOpenStreetMapResponse());

        Opportunity testOpportunity = [SELECT Id FROM Opportunity LIMIT 1];

        Test.startTest();
        System.enqueueJob(new OpportunityQueueable(testOpportunity.Id));
        Test.stopTest();

        Opportunity updatedOpp = [SELECT latitude__c, longitude__c FROM Opportunity WHERE Id = :testOpportunity.Id];

        System.assertNotEquals(null, updatedOpp.latitude__c, 'Latitude should be set');
        System.assertNotEquals(null, updatedOpp.longitude__c, 'Longitude should be set');
    }
}