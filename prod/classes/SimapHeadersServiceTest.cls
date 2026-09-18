@isTest
public class SimapHeadersServiceTest {

    public static final String ONE_PROJECT_LAST_ITEM = 'one_project_last_item';
    public static final String TWO_PROJECTS_LAST_ITEM = 'two_projects_last_item';

    @TestSetup
    public static void setUpTestEnv() {
        TestDataFactory.createTestData();
    }

    @isTest
    public static void testSearchByCriteria() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

        Test.startTest();
            String response = SimapHeadersService.searchByCriteria(ONE_PROJECT_LAST_ITEM);
        Test.stopTest();

        SimapHeadersService.SimapResponse parsedResponse = (SimapHeadersService.SimapResponse)JSON.deserialize(response, SimapHeadersService.SimapResponse.class);
        SimapHeadersService.PublicationDeserializer incomingHeader = parsedResponse.projects[0];

        System.assertEquals(TestDataFactory.PUBLICATION_TYPE_TENDER_NAME, incomingHeader.projectType, 'testSearchByCriteria : Project type should be tender');
        System.assertEquals(TestDataFactory.PUBLICATION_PROCESS_TYPE_OPEN_NAME, incomingHeader.processType, 'testSearchByCriteria : wrong process type');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_NUMBER, incomingHeader.publicationNumber, 'testSearchByCriteria : wrong publication number');
        System.assertEquals(TestDataFactory.PUBLICATION_ADJUDICATION_ACTIVE_NAME, incomingHeader.pubType, 'testSearchByCriteria : wrong publication type');
        System.assertEquals(false, incomingHeader.corrected, 'testSearchByCriteria : wrong corrected status');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_PAGE_ID, incomingHeader.id, 'testSearchByCriteria : wrong publication page id');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_PROJECT_NUMBER, incomingHeader.projectNumber, 'testSearchByCriteria : wrong project number');
        System.assertEquals(TestDataFactory.FR, incomingHeader.title.fr, 'testSearchByCriteria : wrong title');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_DATE, incomingHeader.publicationDate, 'testSearchByCriteria : wrong publication date');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_DETAIL_ID, incomingHeader.publicationId, 'testSearchByCriteria : wrong publication detail id');
        System.assertEquals(TestDataFactory.FR, incomingHeader.procOfficeName.fr, 'testSearchByCriteria : wrong proc office name');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_OFFER_DEADLINE, incomingHeader.offerDeadline, 'testSearchByCriteria : wrong offer deadline');
    }

    @isTest
    public static void testfetchSimapByCriteria() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

        Test.startTest();
            SimapHeadersService.SimapResponse response = SimapHeadersService.fetchSimapByCriteria(ONE_PROJECT_LAST_ITEM);
        Test.stopTest();

        System.assertNotEquals(null, response, 'testfetchSimapByCriteria : response should not be null');
        System.assertEquals(1, response.projects.size(), 'testfetchSimapByCriteria : wrong number of projects');
    }

    @isTest
    public static void testFetchSimapByKeyWord() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

        Test.startTest();
            SimapHeadersService.SimapResponse response = SimapHeadersService.fetchSimapByKeyWord(TestDataFactory.INCOMING_PUBLICATION_DETAIL_REFERENCE, ONE_PROJECT_LAST_ITEM);
        Test.stopTest();

        System.assertNotEquals(null, response, 'testFetchSimapByKeyWord : response should not be null');
        System.assertEquals(1, response.projects.size(), 'testFetchSimapByKeyWord : wrong number of projects');
    }

    @isTest
    public static void testSearchByKeyWord() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());
            
        Test.startTest();
            String response = SimapHeadersService.searchByKeyWord(TestDataFactory.INCOMING_PUBLICATION_DETAIL_REFERENCE, ONE_PROJECT_LAST_ITEM);
        Test.stopTest();

        SimapHeadersService.SimapResponse parsedResponse = (SimapHeadersService.SimapResponse)JSON.deserialize(response, SimapHeadersService.SimapResponse.class);
        SimapHeadersService.PublicationDeserializer incomingHeader = parsedResponse.projects[0];
    
        System.assertEquals(TestDataFactory.PUBLICATION_TYPE_TENDER_NAME, incomingHeader.projectType, 'testSearchByCriteria : Project type should be tender');
        System.assertEquals(TestDataFactory.PUBLICATION_PROCESS_TYPE_OPEN_NAME, incomingHeader.processType, 'testSearchByCriteria : wrong process type');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_NUMBER, incomingHeader.publicationNumber, 'testSearchByCriteria : wrong publication number');
        System.assertEquals(TestDataFactory.PUBLICATION_ADJUDICATION_ACTIVE_NAME, incomingHeader.pubType, 'testSearchByCriteria : wrong publication type');
        System.assertEquals(false, incomingHeader.corrected, 'testSearchByCriteria : wrong corrected status');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_PAGE_ID, incomingHeader.id, 'testSearchByCriteria : wrong publication page id');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_PROJECT_NUMBER, incomingHeader.projectNumber, 'testSearchByCriteria : wrong project number');
        System.assertEquals(TestDataFactory.FR, incomingHeader.title.fr, 'testSearchByCriteria : wrong title');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_DATE, incomingHeader.publicationDate, 'testSearchByCriteria : wrong publication date');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_DETAIL_ID, incomingHeader.publicationId, 'testSearchByCriteria : wrong publication detail id');
        System.assertEquals(TestDataFactory.FR, incomingHeader.procOfficeName.fr, 'testSearchByCriteria : wrong proc office name');
        System.assertEquals(TestDataFactory.INCOMING_PUBLICATION_OFFER_DEADLINE, incomingHeader.offerDeadline, 'testSearchByCriteria : wrong offer deadline');
    }

    @isTest
    public static void testSearchByKeyWordNoResults() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

        Test.startTest();
            String response = SimapHeadersService.searchByKeyWord(TestDataFactory.NON_EXISTING_KEYWORD, null);
        Test.stopTest();

        SimapHeadersService.SimapResponse parsedResponse = (SimapHeadersService.SimapResponse)JSON.deserialize(response, SimapHeadersService.SimapResponse.class);

        System.assertEquals(0, parsedResponse.projects.size(), 'testSearchByCriteriaNoResults : wrong number of projects');
    }

    @isTest
    public static void testGetSimapResponse() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());
        String params = SimapHeadersService.getUrlParams(ONE_PROJECT_LAST_ITEM);

        Test.startTest();
            SimapHeadersService.SimapResponse response = SimapHeadersService.getSimapResponse(params);
        Test.stopTest();

        System.assertNotEquals(null, response, 'testGetSimapResponse : response should not be null');
        System.assertEquals(1, response.projects.size(), 'testGetSimapResponse : wrong number of projects');
    }

    @isTest
    public static void testFetchNewPublications() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());
        String params = SimapHeadersService.getUrlParams(ONE_PROJECT_LAST_ITEM);

        Test.startTest();
            String response = SimapHeadersService.fetchNewPublications(params);
        Test.stopTest();

        System.assertNotEquals(null, response, 'testFetchNewPublications : response should not be null');
        System.assertEquals(MockHttpSimapResponse.oneProjectBody, response, 'testFetchNewPublications : wrong response');
    }

    @isTest
    public static void testGetUrlParams() {
        String selectedCantonParam = SimapHeadersService.ISSUED_BY_ORGANIZATIONS_PARAM + TestDataFactory.VAUD_CANTON_ID;
        String selectedFederalEntityParam = SimapHeadersService.ISSUED_BY_ORGANIZATIONS_PARAM + TestDataFactory.FEDERAL_ENTITY1_ID;
        String selectedCodeCPVParam = SimapHeadersService.CPV_CODES_PARAM + TestDataFactory.CPV_CODE1_CODE;
        String projectSubTypeParam = SimapHeadersService.PROJECT_SUBTYPE_PARAM + SimapHeadersService.projectSubTypes[0];

        Test.startTest();
            String params = SimapHeadersService.getUrlParams(ONE_PROJECT_LAST_ITEM);
            String paramsWithNullLastItem = SimapHeadersService.getUrlParams(null);
        Test.stopTest();

        System.assertEquals(true, params.contains(selectedCAntonParam), 'testGetUrlParams : selected canton param should be present');
        System.assertEquals(true, params.contains(selectedFederalEntityParam), 'testGetUrlParams : selected federal entity param should be present');
        System.assertEquals(true, params.contains(selectedCodeCPVParam), 'testGetUrlParams : selected code CPV param should be present');
        System.assertEquals(true, params.contains(projectSubTypeParam), 'testGetUrlParams : project sub type param should be present');
        System.assertEquals(false, paramsWithNullLastItem.contains(SimapHeadersService.LAST_ITEM_PARAM), 'testGetUrlParams : last item param should be present');
    }

    @isTest
    public static void testAddPublicationVisitedStatus() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());
        
        Test.startTest();
            SimapHeadersService.SimapResponse response = SimapHeadersService.fetchSimapByCriteria(TWO_PROJECTS_LAST_ITEM);
            response = SimapHeadersService.addPublicationVisitedStatus(response);
        Test.stopTest();

        System.assertEquals(2, response.projects.size(), 'testAddPublicationVisitedStatus : wrong number of projects');
        System.assertEquals(SimapHeadersService.NEW_STATUS, response.projects[0].actionStatus, 'testAddPublicationVisitedStatus : first project should be visited');
        System.assertEquals(SimapHeadersService.VISITED_STATUS, response.projects[1].actionStatus, 'testAddPublicationVisitedStatus : second project should be visited');
    }

    @isTest
    public static void testAddPublicationVisitedStatus_WithOpportunity() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());
        TriggerHandler.bypassOpportunityTrigger = true;
        
        Opportunity opp = [
            SELECT
                Id
            FROM
                Opportunity
            LIMIT 1
        ];

        Publication_Simap__c pubToUpdate = [
            SELECT
                Id,
                Opportunity__c
            FROM
                Publication_Simap__c
            LIMIT 1
        ];

        pubToUpdate.Opportunity__c = opp.Id;
        update pubToUpdate;

        Test.startTest();
            SimapHeadersService.SimapResponse response = SimapHeadersService.fetchSimapByCriteria(TWO_PROJECTS_LAST_ITEM);
            response = SimapHeadersService.addPublicationVisitedStatus(response);
        Test.stopTest();

        System.assertEquals(2, response.projects.size(), 'testAddPublicationVisitedStatus_WithOpportunity : wrong number of projects');
        System.assertEquals(SimapHeadersService.CONVERTED_STATUS, response.projects[1].actionStatus, 'testAddPublicationVisitedStatus_WithOpportunity : first project should be converted');
    }

    @isTest
    public static void testAddSelectedSearchFilters() {
        Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

        Test.startTest();
            SimapHeadersService.SimapResponse response = SimapHeadersService.fetchSimapByCriteria(TWO_PROJECTS_LAST_ITEM);
            response = SimapHeadersService.addSelectedSearchFilters(response);
        Test.stopTest();

        System.assertEquals(1, response.filters.cantonalEntities.size(), 'testAddSelectedSearchFilters : wrong number of selected canton entities');
        System.assertEquals(1, response.filters.federalEntities.size(), 'testAddSelectedSearchFilters : wrong number of selected federal entities');
        System.assertEquals(1, response.filters.simapCodesCPV.size(), 'testAddSelectedSearchFilters : wrong number of selected CPV codes');
        System.assertEquals(TestDataFactory.VAUD_CANTON_NAME, response.filters.cantonalEntities[0].get('Name'), 'testAddSelectedSearchFilters : wrong selected canton entity');
        System.assertEquals(TestDataFactory.FEDERAL_ENTITY1_NAME, response.filters.federalEntities[0].get('Name'), 'testAddSelectedSearchFilters : wrong selected federal entity');
        System.assertEquals(TestDataFactory.CPV_CODE1_CODE, response.filters.simapCodesCPV[0].Code_CPV__c, 'testAddSelectedSearchFilters : wrong selected CPV code');
    }

}