@isTest
public class TestDataFactory {

    public static final String VAUD_CANTON_NAME = 'Vaud';
    public static final String VAUD_CANTON_ID = 'id_of_Vaud_canton';
    public static final Boolean VAUD_CANTON_IN_API_SIMAP = true;
    public static final String VAUD_CANTON_ABBREVIATION = 'VD';
    public static final String GENEVE_CANTON_NAME = 'Geneve';
    public static final String GENEVE_CANTON_ID = 'id_of_Geneve_canton';
    public static final Boolean GENEVE_CANTON_IN_API_SIMAP = false;
    public static final String GENEVE_CANTON_ABBREVIATION = 'GE';

    public static final String FEDERAL_ENTITY1_NAME = 'federalEntity1';
    public static final String FEDERAL_ENTITY1_ID = 'id_of_federalEntity1';
    public static final Boolean FEDERAL_ENTITY1_IN_API_SIMAP = true;
    public static final String FEDERAL_ENTITY2_NAME = 'federalEntity2';
    public static final String FEDERAL_ENTITY2_ID = 'id_of_federalEntity2';
    public static final Boolean FEDERAL_ENTITY2_IN_API_SIMAP = false;

    public static final String CPV_CODE1_NAME = 'CPV_Code_1';
    public static final String CPV_CODE1_SECTOR = 'Construction';
    public static final String CPV_CODE1_CODE = '123';
    public static final Boolean CPV_CODE1_APPLY_CANTONAL_SEARCH = true;
    public static final Boolean CPV_CODE1_APPLY_FEDERAL_SEARCH = true;
    public static final String CPV_CODE2_NAME = 'CPV_Code_2';
    public static final String CPV_CODE2_SECTOR = 'non pertinent';
    public static final String CPV_CODE2_CODE = '456';
    public static final Boolean CPV_CODE2_APPLY_CANTONAL_SEARCH = false;
    public static final Boolean CPV_CODE2_APPLY_FEDERAL_SEARCH = false;

    public static final String PUBLICATION_TYPE_TENDER_NAME = 'Tender';
    public static final Boolean PUBLICATION_TYPE_TENDER_APPLIED = true;
    public static final String PUBLICATION_TYPE_TENDER_VALUE = 'tender';

    public static final String PUBLICATION_TYPE_INACTIVE_NAME = 'Inactive';
    public static final Boolean PUBLICATION_TYPE_INACTIVE_APPLIED = false;
    public static final String PUBLICATION_TYPE_INACTIVE_VALUE = 'infactive';

    public static final String PUBLICATION_PROCESS_TYPE_OPEN_NAME = 'Open';
    public static final Boolean PUBLICATION_PROCESS_TYPE_OPEN_APPLIED = true;
    public static final String PUBLICATION_PROCESS_TYPE_OPEN_VALUE = 'open';

    public static final String PUBLICATION_PROCESS_TYPE_INACTIVE_NAME = 'Inactive';
    public static final Boolean PUBLICATION_PROCESS_TYPE_NACTIVE_APPLIED = false;
    public static final String PUBLICATION_PROCESS_TYPE_INACTIVE_VALUE = 'infactive';

    public static final String PUBLICATION_ADJUDICATION_ACTIVE_NAME = 'Adjudication';
    public static final Boolean PUBLICATION_ADJUDICATION_ACTIVE_APPLIED = true;
    public static final String PUBLICATION_ADJUDICATION_ACTIVE_VALUE = 'adjudication';

    public static final String PUBLICATION_ADJUDICATION_INACTIVE_NAME = 'Inactive';
    public static final Boolean PUBLICATION_ADJUDICATION_NACTIVE_APPLIED = false;
    public static final String PUBLICATION_ADJUDICATION_INACTIVE_VALUE = 'infactive';

    public static final String FR = 'fr';
    public static final String DE = 'de';
    public static final String IT = 'it';
    public static final String EN = 'en';

    public static final String COUNTRY_CODE = 'CH';
    public static final String POSTAL_CODE = '1234';
    public static final String CANTON_ID = 'CT';

    public static final String INCOMING_PUBLICATION_NUMBER = '100';
    public static final String INCOMING_PUBLICATION_PAGE_ID = '101';
    public static final String INCOMING_PUBLICATION_PROJECT_NUMBER = '102';
    public static final String INCOMING_PUBLICATION_DATE = '2024-08-23';
    public static final String INCOMING_PUBLICATION_DETAIL_ID = '103';
    public static final String INCOMING_PUBLICATION_OFFER_DEADLINE = '2024-10-07T11:00:00+02:00';

    public static final String EXISTING_PUBLICATION_NUMBER = '200';
    public static final String EXISTING_PUBLICATION_PAGE_ID = '201';
    public static final String EXISTING_PUBLICATION_PROJECT_NUMBER = '202';
    public static final String EXISTING_PUBLICATION_DATE = '2024-08-24';
    public static final String EXISTING_PUBLICATION_DETAIL_ID = '203';
    public static final String EXISTING_PUBLICATION_OFFER_DEADLINE = '2024-10-08';

    public static final String NON_EXISTING_KEYWORD = 'non_existing_keyword';

    public static final String SIMAP_HEADER_RESPONSE_1 = String.join(new List<String>{
        '{"projectType":' + '"' + PUBLICATION_TYPE_TENDER_NAME + '"' + ',',
        '"processType":' + '"' + PUBLICATION_PROCESS_TYPE_OPEN_NAME + '"' + ',',
        '"publicationNumber":' + '"' + INCOMING_PUBLICATION_NUMBER + '"' + ',',
        '"pubType":' + '"' + PUBLICATION_ADJUDICATION_ACTIVE_NAME + '"' + ',',
        '"corrected":false,',
        '"id":' + '"' + INCOMING_PUBLICATION_PAGE_ID + '"' + ',',
        '"projectNumber":' + '"' + INCOMING_PUBLICATION_PROJECT_NUMBER + '"' + ',',
        '"title":{"de":null,"en":null,"fr":' + '"' + FR + '"' + ',"it":""},',
        '"publicationDate":' + '"' + INCOMING_PUBLICATION_DATE + '"' + ',',
        '"publicationId":' + '"' + INCOMING_PUBLICATION_DETAIL_ID + '"' + ',',
        '"procOfficeName":{"de":null,"en":null,"fr":' + '"' + FR + '"' + ',"it":null},',
        '"offerDeadline":' + '"' + INCOMING_PUBLICATION_OFFER_DEADLINE + '"' + '}'
    }, '\n');

    public static final String SIMAP_HEADER_RESPONSE_2 = String.join(new List<String>{
        '{"projectType":' + '"' + PUBLICATION_TYPE_TENDER_NAME + '"' + ',',
        '"processType":' + '"' + PUBLICATION_PROCESS_TYPE_OPEN_NAME + '"' + ',',
        '"publicationNumber":' + '"' + EXISTING_PUBLICATION_NUMBER + '"' + ',',
        '"pubType":' + '"' + PUBLICATION_ADJUDICATION_ACTIVE_NAME + '"' + ',',
        '"corrected":false,',
        '"id":' + '"' + EXISTING_PUBLICATION_PAGE_ID + '"' + ',',
        '"projectNumber":' + '"' + EXISTING_PUBLICATION_PROJECT_NUMBER + '"' + ',',
        '"title":{"de":null,"en":null,"fr":' + '"' + FR + '"' + ',"it":""},',
        '"publicationDate":' + '"' + EXISTING_PUBLICATION_DATE + '"' + ',',
        '"publicationId":' + '"' + EXISTING_PUBLICATION_DETAIL_ID + '"' + ',',
        '"procOfficeName":{"de":null,"en":null,"fr":' + '"' + FR + '"' + ',"it":null},',
        '"offerDeadline":' + '"' + EXISTING_PUBLICATION_OFFER_DEADLINE + '"' + '}'
    }, '\n');

    public static final String INCOMING_PUBLICATION_DETAIL_POSTAL_CODE = '3000';
    public static final String INCOMING_PUBLICATION_DETAIL_PHONE = '031 123 45 67';
    public static final String INCOMING_PUBLICATION_DETAIL_EMAIL = 'office@simap.ch';
    public static final String INCOMING_PUBLICATION_DETAIL_REFERENCE = '12345';
    public static final String INCOMING_PUBLICATION_DETAIL_TED_STATUS = 'Publié';
    public static final String INCOMING_PUBLICATION_DETAIL_TED_URL = 'http://ted.europa.eu';
    public static final String INCOMING_PUBLICATION_DETAIL_BASE_TYPE = 'Avis de marché';
    public static final String INCOMING_PUBLICATION_DETAIL_BASE_PROCESS_TYPE = 'Procédure ouverte';

    public static final String SIMAP_DETAIL_RESPONSE_1 = String.join(new List<String>{
        '{',
        '  "procurement": {',
        '    "orderDescription": {"de":null,"en":null,"fr":"' + FR + '","it":""}',
        '  },',
        '  "project-info": {',
        '    "procOfficeAddress": {',
        '      "postalCode": "' + INCOMING_PUBLICATION_DETAIL_POSTAL_CODE + '",',
        '      "cantonId": "' + VAUD_CANTON_ABBREVIATION + '",',
        '      "countryId": "' + COUNTRY_CODE + '",',
        '      "phone": "' + INCOMING_PUBLICATION_DETAIL_PHONE + '",',
        '      "email": "' + INCOMING_PUBLICATION_DETAIL_EMAIL + '",',
        '      "reference": "' + INCOMING_PUBLICATION_DETAIL_REFERENCE + '",',
        '      "name": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '      "url": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '      "street": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '      "city": {"de":null,"en":null,"fr":"' + FR + '","it":""}',
        '    },',
        '    "procurementRecipientAddress": null,',
        '    "offerAddress": null,',
        '    "offerSpecificNote": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '    "documentsSourceNote": {"de":null,"en":null,"fr":"' + FR + '","it":""}',
        '  },',
        '  "projectInfo": {',
        '    "procOfficeAddress": {',
        '      "postalCode": "' + INCOMING_PUBLICATION_DETAIL_POSTAL_CODE + '",',
        '      "cantonId": "' + VAUD_CANTON_ABBREVIATION + '",',
        '      "countryId": "' + COUNTRY_CODE + '",',
        '      "phone": "' + INCOMING_PUBLICATION_DETAIL_PHONE + '",',
        '      "email": "' + INCOMING_PUBLICATION_DETAIL_EMAIL + '",',
        '      "reference": "' + INCOMING_PUBLICATION_DETAIL_REFERENCE + '",',
        '      "name": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '      "url": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '      "street": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '      "city": {"de":null,"en":null,"fr":"' + FR + '","it":""}',
        '    },',
        '    "procurementRecipientAddress": null,',
        '    "offerAddress": null,',
        '    "offerSpecificNote": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '    "documentsSourceNote": {"de":null,"en":null,"fr":"' + FR + '","it":""}',
        '  },',
        '  "base": {',
        '    "cpvCode": {',
        '      "code": "' + CPV_CODE1_CODE + '",',
        '      "label": {"de":null,"en":null,"fr":"' + FR + '","it":""}',
        '    },',
        '    "title": {"de":null,"en":null,"fr":"' + FR + '","it":""},',
        '    "publicationNumber": "' + EXISTING_PUBLICATION_NUMBER + '",',
        '    "type": "' + INCOMING_PUBLICATION_DETAIL_BASE_TYPE + '",',
        '    "processType": "' + INCOMING_PUBLICATION_DETAIL_BASE_PROCESS_TYPE + '"',
        '  },',
        '  "dates": {',
        '    "offerDeadline": "' + EXISTING_PUBLICATION_OFFER_DEADLINE + '",',
        '    "publicationDate": "' + EXISTING_PUBLICATION_DATE + '"',
        '  },',
        '  "ted": {',
        '    "status": "' + INCOMING_PUBLICATION_DETAIL_TED_STATUS + '",',
        '    "url": "' + INCOMING_PUBLICATION_DETAIL_TED_URL + '"',
        '  }',
        '}'
    }, '\n');
    
    public static void createTestData() {
        createCantons();
        createFederalEntities();
        createCodesCPV();
        createPublicationTypes();
        createProcedureTypes();
        createAdjudications();
        insertPublicationHeader();
        insertOpportunity();
    }

    public static void createCantons () {
        Simap_Cantons__c vaud = new Simap_Cantons__c();
        Simap_Cantons__c geneve = new Simap_Cantons__c();

        vaud.Name = VAUD_CANTON_NAME;
        vaud.simap_id__c = VAUD_CANTON_ID;
        vaud.inclus_dans_API_SIMAP__c = VAUD_CANTON_IN_API_SIMAP;
        vaud.Abbreviation__c = VAUD_CANTON_ABBREVIATION;

        geneve.Name = GENEVE_CANTON_NAME;
        geneve.simap_id__c	= GENEVE_CANTON_ID;
        geneve.inclus_dans_API_SIMAP__c = GENEVE_CANTON_IN_API_SIMAP;
        geneve.Abbreviation__c = GENEVE_CANTON_ABBREVIATION;

        insert vaud;
        insert geneve;
    }

    public static void createFederalEntities () {
        Simap_Federal_Entities__c federalEntity1 = new Simap_Federal_Entities__c();
        Simap_Federal_Entities__c federalEntity2 = new Simap_Federal_Entities__c();

        federalEntity1.Name = FEDERAL_ENTITY1_NAME;
        federalEntity1.simap_id__c = FEDERAL_ENTITY1_ID;
        federalEntity1.inclus_dans_API_SIMAP__c = FEDERAL_ENTITY1_IN_API_SIMAP;

        federalEntity2.Name = FEDERAL_ENTITY2_NAME;
        federalEntity2.simap_id__c = FEDERAL_ENTITY2_ID;
        federalEntity2.inclus_dans_API_SIMAP__c = FEDERAL_ENTITY2_IN_API_SIMAP;

        insert federalEntity1;
        insert federalEntity2;
    }

    public static void createCodesCPV() {
        Simap_Code_CPV__c activeCPVCode = new Simap_Code_CPV__c();
        Simap_Code_CPV__c inactiveCPVCode = new Simap_Code_CPV__c();

        activeCPVCode.Name = CPV_CODE1_NAME;
        activeCPVCode.Secteur_d_activite__c = CPV_CODE1_SECTOR;
        activeCPVCode.Code_CPV__c = CPV_CODE1_CODE;
        activeCPVCode.appliquer_recherche_CANTONALE__c = CPV_CODE1_APPLY_CANTONAL_SEARCH;
        activeCPVCode.appliquer_recherche_FEDERALE__c = CPV_CODE1_APPLY_FEDERAL_SEARCH;

        inactiveCPVCode.Name = CPV_CODE2_NAME;
        inactiveCPVCode.Secteur_d_activite__c = CPV_CODE2_SECTOR;
        inactiveCPVCode.Code_CPV__c = CPV_CODE2_CODE;
        inactiveCPVCode.appliquer_recherche_CANTONALE__c = CPV_CODE2_APPLY_CANTONAL_SEARCH;
        inactiveCPVCode.appliquer_recherche_FEDERALE__c = CPV_CODE2_APPLY_CANTONAL_SEARCH;

        insert activeCPVCode;
        insert inactiveCPVCode;
    }

    public static void createPublicationTypes() {
        Simap_Type_de_Publication__c activeTenderType = new Simap_Type_de_Publication__c();
        Simap_Type_de_Publication__c inactiveTenderType = new Simap_Type_de_Publication__c();

        activeTenderType.Name = PUBLICATION_TYPE_TENDER_NAME;
        activeTenderType.simap_value__c = PUBLICATION_TYPE_TENDER_VALUE;
        activeTenderType.inclus_dans_API_SIMAP__c = PUBLICATION_TYPE_TENDER_APPLIED;

        inactiveTenderType.Name = PUBLICATION_TYPE_INACTIVE_NAME;
        inactiveTenderType.simap_value__c = PUBLICATION_TYPE_INACTIVE_VALUE;
        inactiveTenderType.inclus_dans_API_SIMAP__c = PUBLICATION_TYPE_INACTIVE_APPLIED;

        insert activeTenderType;
        insert inactiveTenderType;
    }

    public static void createProcedureTypes() {
        Simap_Type_de_procedure__c activeOpenType = new Simap_Type_de_procedure__c();
        Simap_Type_de_procedure__c inactiveOpenType = new Simap_Type_de_procedure__c();

        activeOpenType.Name = PUBLICATION_PROCESS_TYPE_OPEN_NAME;
        activeOpenType.simap_value__c = PUBLICATION_PROCESS_TYPE_OPEN_VALUE;
        activeOpenType.inclus_dans_API_SIMAP__c = PUBLICATION_PROCESS_TYPE_OPEN_APPLIED;

        inactiveOpenType.Name = PUBLICATION_PROCESS_TYPE_INACTIVE_NAME;
        inactiveOpenType.simap_value__c = PUBLICATION_PROCESS_TYPE_INACTIVE_VALUE;
        inactiveOpenType.inclus_dans_API_SIMAP__c = PUBLICATION_PROCESS_TYPE_NACTIVE_APPLIED;

        insert activeOpenType;
        insert inactiveOpenType;
    }

    public static void createAdjudications() {
        Simap_Adjudications_et_mises_a_jour__c activeAdjudication = new Simap_Adjudications_et_mises_a_jour__c();
        Simap_Adjudications_et_mises_a_jour__c inactiveAdjudication = new Simap_Adjudications_et_mises_a_jour__c();

        activeAdjudication.Name = PUBLICATION_ADJUDICATION_ACTIVE_NAME;
        activeAdjudication.simap_value__c = PUBLICATION_ADJUDICATION_ACTIVE_VALUE;
        activeAdjudication.inclus_dans_API_SIMAP__c = PUBLICATION_ADJUDICATION_ACTIVE_APPLIED;

        inactiveAdjudication.Name = PUBLICATION_ADJUDICATION_INACTIVE_NAME;
        inactiveAdjudication.simap_value__c = PUBLICATION_ADJUDICATION_INACTIVE_VALUE;
        inactiveAdjudication.inclus_dans_API_SIMAP__c = PUBLICATION_ADJUDICATION_NACTIVE_APPLIED;

        insert activeAdjudication;
        insert inactiveAdjudication;
    }

    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static SimapHeadersService.SimapSwissLangSet createSwissLangset(String francais, String deutsch, String italiano, String english) {
        SimapHeadersService.SimapSwissLangSet langSet = new SimapHeadersService.SimapSwissLangSet();
    
        langSet.fr = francais;
        langSet.de = deutsch;
        langSet.it = italiano;
        langSet.en = english;

        return langSet;
    }

    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static SimapPublicationDetailService.SimapAdress createAddress(
        SimapHeadersService.SimapSwissLangSet city,
        SimapHeadersService.SimapSwissLangSet street,
        String countryId,
        String postalCode,
        String cantonId
    ) {
        SimapPublicationDetailService.SimapAdress addr = new SimapPublicationDetailService.SimapAdress();

        addr.city = city;
        addr.street = street;
        addr.countryId = countryId;
        addr.postalCode = postalCode;
        addr.cantonId = cantonId;

        return addr;
    }

    public static void insertPublicationHeader() {
        Publication_Simap__c existingPubHeader = new Publication_Simap__c();

        existingPubHeader.Name = PublicationSimap.PUBLICATION_PREFIX + EXISTING_PUBLICATION_NUMBER;
        existingPubHeader.Numero_de_publication__c = EXISTING_PUBLICATION_NUMBER;
        existingPubHeader.Id_publication_page__c = EXISTING_PUBLICATION_PAGE_ID;
        existingPubHeader.Numero_de_projet__c = EXISTING_PUBLICATION_PROJECT_NUMBER;
        existingPubHeader.Date_de_publication__c = Date.valueOf(EXISTING_PUBLICATION_DATE);
        existingPubHeader.Id_publication_detail__c = EXISTING_PUBLICATION_DETAIL_ID;
        existingPubHeader.Deadline_Offre__c = Date.valueOf(EXISTING_PUBLICATION_OFFER_DEADLINE);
        existingPubHeader.Type_de_projet__c = PUBLICATION_TYPE_TENDER_NAME;
        existingPubHeader.Type_de_process__c = PUBLICATION_PROCESS_TYPE_OPEN_NAME;
        existingPubHeader.Corrige__c = false;

        insert existingPubHeader;
    }

    public static void insertOpportunity() {
        TriggerHandler.bypassOpportunityTrigger = true;

        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = Date.today().addDays(30);

        insert opp;
    }

}