@isTest
global class SimapServiceTest {
    
    static Simap_Cantons__c vaud = new Simap_Cantons__c();
    static Simap_Cantons__c geneve = new Simap_Cantons__c();
    static Simap_Cantons__c zurich = new Simap_Cantons__c();

    static Simap_Federal_Entities__c administration1 = new Simap_Federal_Entities__c();
    static Simap_Federal_Entities__c administration2 = new Simap_Federal_Entities__c();
    static Simap_Federal_Entities__c administration3 = new Simap_Federal_Entities__c();

    static Simap_Code_CPV__c activeCPVCode = new Simap_Code_CPV__c();
    static Simap_Code_CPV__c inactiveCPVCode = new Simap_Code_CPV__c();

    @TestSetup
    public static void setUpTestEnv() {
        vaud.Name = 'Vaud';
        vaud.simap_canton_id__c	= 'id_of_Vaud_canton';
        vaud.inclus_dans_API_SIMAP__c = true;

        geneve.Name = 'Geneve';
        geneve.simap_canton_id__c	= 'id_of_Geneve_canton';
        geneve.inclus_dans_API_SIMAP__c = true;

        zurich.Name = 'Zurich';
        zurich.simap_canton_id__c	= 'id_of_Zurich_canton';
        zurich.inclus_dans_API_SIMAP__c = false;

        insert vaud;
        insert geneve;
        insert zurich;

        administration1.Name = 'Administration1';
        administration1.simap_federal_entity_id__c = 'id_of_Administration1';
        administration1.inclus_dans_API_SIMAP__c = true;

        administration2.Name = 'Administration2';
        administration2.simap_federal_entity_id__c = 'id_of_Administration2';
        administration2.inclus_dans_API_SIMAP__c = true;

        administration3.Name = 'Administration3';
        administration3.simap_federal_entity_id__c = 'id_of_Administration3';
        administration3.inclus_dans_API_SIMAP__c = true;

        insert administration1;
        insert administration2;
        insert administration3;

        activeCPVCode.Name = 'CPV_Code_1';
        activeCPVCode.Secteur_d_activite__c = 'Construction';
        activeCPVCode.Code_CPV__c = '123';
        activeCPVCode.appliquer_recherche_CANTONALE__c = true;
        activeCPVCode.appliquer_recherche_FEDERALE__c = true;

        inactiveCPVCode.Name = 'CPV_Code_2';
        inactiveCPVCode.Secteur_d_activite__c = 'non pertinent';
        inactiveCPVCode.Code_CPV__c = '456';
        inactiveCPVCode.appliquer_recherche_CANTONALE__c = false;
        inactiveCPVCode.appliquer_recherche_FEDERALE__c = false;

        insert activeCPVCode;
        insert inactiveCPVCode;
    }

    // @isTest
    // public static void testGetSimapEntitiesByContext() {
    //     List<Simap_Cantons__c> cantons;
    //     List<Simap_Federal_Entities__c> federalEntities;

    //     Test.startTest();
    //         cantons = SimapService.getSimapEntitiesByContext(SimapService.SimapContext.CANTONAL);
    //         federalEntities = SimapService.getSimapEntitiesByContext(SimapService.SimapContext.FEDERAL);
    //     Test.stopTest();

    //     System.assertEquals(2, cantons.size(), 'testGetSimapEntitiesByContext :  the size of cantons retrieved should be 2');
    //     System.assertEquals(3, federalEntities.size(), 'testGetSimapEntitiesByContext :  the size of federalEntities retrieved should be 3');
    // }

    // @isTest
    // public static void testGetSimapCodesCPV() {
    //     List<Simap_Code_CPV__c> activeCPVCodesCantonal;
    //     List<Simap_Code_CPV__c> activeCPVCodesFederal;

    //     Test.startTest();
    //         activeCPVCodesFederal = SimapService.getSimapCodesCPV(SimapService.SimapContext.FEDERAL);
    //         activeCPVCodesCantonal = SimapService.getSimapCodesCPV(SimapService.SimapContext.CANTONAL);
    //     Test.stopTest();

    //     System.assertEquals(1, activeCPVCodesCantonal.size(), 'testGetSimapCodesCPV : the size of activeCPVCodesCantonal should be 1');
    //     System.assertEquals(1, activeCPVCodesFederal.size(), 'testGetSimapCodesCPV : the size of activeCPVCodesFederal should be 1');
    // }

    // @isTest
    // public static void testGetUrlParams() {
    //     String expectedCantonalFetchParams = 'projectSubTypes=construction&issuedByOrganizations=id_of_Vaud_canton&issuedByOrganizations=id_of_Geneve_canton&cpvCode=123';
    //     String expectedFederalFetchParams = 'projectSubTypes=construction&issuedByOrganizations=id_of_Administration1&issuedByOrganizations=id_of_Administration2&issuedByOrganizations=id_of_Administration3&cpvCode=123';

    //     String actualCantonalFetchParams;
    //     String actualFederalFetchParams;

    //     Test.startTest();
    //         actualCantonalFetchParams = SimapService.getUrlParams(SimapService.SimapContext.CANTONAL, null);
    //         actualFederalFetchParams = SimapService.getUrlParams(SimapService.SimapContext.FEDERAL, null);
    //     Test.stopTest();
        
    //     System.assertEquals(expectedCantonalFetchParams, actualCantonalFetchParams, 'testGetUrlParams : the url parameters string is incorrect. Actual : ' + actualCantonalFetchParams);
    //     System.assertEquals(expectedFederalFetchParams, actualFederalFetchParams, 'testGetUrlParams : the url parameters string is incorrect. Actual : ' + actualFederalFetchParams);
    // }

    // @isTest
    // public static void testBuildSimapRequest() {
    //     String actualCantonalParams = SimapService.getUrlParams(SimapService.SimapContext.CANTONAL, null);
    //     String actualFederalParams = SimapService.getUrlParams(SimapService.SimapContext.FEDERAL, null);
        
    //     String expectedCantonalEndpoint = SimapService.baseSimapURL + actualCantonalParams;
    //     String expectedFederalEndpoint = SimapService.baseSimapURL + actualFederalParams;
    //     String actualCantonalEndpoint;
    //     String actualFederalEndpoint;
        
    //     Test.startTest();
    //         actualCantonalEndpoint = SimapService.buildSimapRequest(actualCantonalParams).getEndpoint();
    //         actualFederalEndpoint = SimapService.buildSimapRequest(actualFederalParams).getEndpoint();
    //     Test.stopTest();

    //     System.assertEquals(expectedCantonalEndpoint, actualCantonalEndpoint, 'testBuildSimapRequest : the cantonal endpoint is incorrect. Actual is : ' + actualCantonalEndpoint);
    //     System.assertEquals(expectedFederalEndpoint, actualFederalEndpoint, 'testBuildSimapRequest : the federal endpoint is incorrect. Actual is : ' + actualFederalEndpoint);
    // }

    // @isTest
    // public static void testFetchNewPublicationsByCantons() {
    //     String cantonalParams = SimapService.getUrlParams(SimapService.SimapContext.CANTONAL, null);
    //     String jsonResponse;

    //     Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

    //     Test.startTest();
    //         jsonResponse = SimapService.fetchNewPublications(cantonalParams);
    //     Test.stopTest();

    //     SimapService.SimapResponse simapResponse = (SimapService.SimapResponse)JSON.deserialize(jsonResponse, SimapService.SimapResponse.class);
    //     System.debug(simapResponse.projects[0]);

    //     System.assertEquals(1, simapResponse.projects.size(), 'testFetchNewPublicationsByCantons : the size of projects should be 1');
    //     System.assertEquals('Test_01', simapResponse.projects[0].publicationNumber, 'testFetchNewPublicationsByCantons :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('publication_page_id', simapResponse.projects[0].id, 'testFetchNewPublicationsByCantons :  wrong id, actual value is : ' + simapResponse.projects[0].id);
    //     System.assertEquals('test_projet_1', simapResponse.projects[0].projectNumber, 'testFetchNewPublicationsByCantons :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('publication_detail_id', simapResponse.projects[0].publicationId, 'testFetchNewPublicationsByCantons :  wrong publicationId, actual value is : ' + simapResponse.projects[0].publicationId);
    //     System.assertEquals('Projet_cantonal_1', simapResponse.projects[0].title.fr, 'teFetchNewPublicationsByCantons :  wrong title, actual value is : ' + simapResponse.projects[0].title.fr);
    // }

    // @isTest
    // public static void testFetchNewPublicationsByCantonsWithPagination() {
    //     String cantonalParams = SimapService.getUrlParams(SimapService.SimapContext.CANTONAL, 'pagination');
    //     String jsonResponse;

    //     Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

    //     Test.startTest();
    //         jsonResponse = SimapService.fetchNewPublications(cantonalParams);
    //     Test.stopTest();

    //     SimapService.SimapResponse simapResponse = (SimapService.SimapResponse)JSON.deserialize(jsonResponse, SimapService.SimapResponse.class);
    //     System.debug(simapResponse.projects[0]);

    //     System.assertEquals(1, simapResponse.projects.size(), 'testFetchNewPublicationsByCantons : the size of projects should be 1');
    //     System.assertEquals('Test_99', simapResponse.projects[0].publicationNumber, 'testFetchNewPublicationsByCantons :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('test_projet_99', simapResponse.projects[0].projectNumber, 'testFetchNewPublicationsByCantons :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('Projet_cantonal_99', simapResponse.projects[0].title.fr, 'teFetchNewPublicationsByCantons :  wrong title, actual value is : ' + simapResponse.projects[0].title.fr);
    // }

    // @isTest
    // public static void testFetchNewPublicationsByFederalEntities() {
    //     String federalParams = SimapService.getUrlParams(SimapService.SimapContext.FEDERAL, null);
    //     String jsonResponse;

    //     Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

    //     Test.startTest();
    //         jsonResponse = SimapService.fetchNewPublications(federalParams);
    //     Test.stopTest();

    //     SimapService.SimapResponse simapResponse = (SimapService.SimapResponse)JSON.deserialize(jsonResponse, SimapService.SimapResponse.class);
    //     System.debug(simapResponse.projects[0]);

    //     System.assertEquals(1, simapResponse.projects.size(), 'testFetchNewPublicationsByCantons : the size of projects should be 1');
    //     System.assertEquals('Test_02', simapResponse.projects[0].publicationNumber, 'testFetchNewPublicationsByCantons :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('publication_page_id', simapResponse.projects[0].id, 'testFetchNewPublicationsByCantons :  wrong id, actual value is : ' + simapResponse.projects[0].id);
    //     System.assertEquals('test_projet_2', simapResponse.projects[0].projectNumber, 'testFetchNewPublicationsByCantons :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('publication_detail_id', simapResponse.projects[0].publicationId, 'testFetchNewPublicationsByCantons :  wrong publicationId, actual value is : ' + simapResponse.projects[0].publicationId);
    //     System.assertEquals('Projet_federal_1', simapResponse.projects[0].title.fr, 'teFetchNewPublicationsByCantons :  wrong title, actual value is : ' + simapResponse.projects[0].title.fr);
    // }

    // @isTest
    // public static void testGetSimapResponse() {
    //     String params = 'projectSubTypes=construction&issuedByOrganizations=id_of_Vaud_canton&issuedByOrganizations=id_of_Geneve_canton';
    //     SimapService.SimapResponse simapResponse;

    //     Test.setMock(HttpCalloutMock.class, new MockHttpSimapResponse());

    //     Test.startTest();
    //         simapResponse = SimapService.getSimapResponse(params);
    //     Test.stopTest();

    //     System.assertEquals('Administration_Test_1', simapResponse.projects[0].procOfficeName.fr, 'testGetSimapResponse :  wrong title, actual value is : ' + simapResponse.projects[0].title.fr);
    //     System.assertEquals('test_projet_1', simapResponse.projects[0].projectNumber, 'testGetSimapResponse :  wrong projectNumber, actual value is : ' + simapResponse.projects[0].projectNumber);
    //     System.assertEquals('publication_detail_id', simapResponse.projects[0].publicationId, 'testGetSimapResponse :  wrong publicationId, actual value is : ' + simapResponse.projects[0].publicationId);
    //     System.assertEquals('Test_01', simapResponse.projects[0].publicationNumber, 'testGetSimapResponse :  wrong publicationNumber, actual value is : ' + simapResponse.projects[0].publicationNumber);
    //     System.assertEquals('Projet_cantonal_1', simapResponse.projects[0].title.fr, 'testGetSimapResponse :  wrong title, actual value is : ' + simapResponse.projects[0].title.fr);
    // }
    
}