@isTest
global class SimapUtilsTest {

    @TestSetup
    public static void setUpTestEnv() {
        TestDataFactory.createTestData();
    }

    @isTest
    public static void testGetSelectedCantonalEntities() {
        List<Simap_Cantons__c> selectedCantons = new List<Simap_Cantons__c>();

        Test.startTest();
            selectedCantons = (List<Simap_Cantons__c>) SimapUtils.getSelectedCantonalEntities();
        Test.stopTest();

        System.assertEquals(1, selectedCantons.size(), 'testGetSelectedCantonalEntities : there should have been only one canton retrieved');
        System.assertEquals(TestDataFactory.VAUD_CANTON_NAME, selectedCantons[0].Name, 'testGetSelectedCantonalEntities : the canton name is wrong');
        System.assertEquals(TestDataFactory.VAUD_CANTON_ID, selectedCantons[0].simap_id__c, 'testGetSelectedCantonalEntities : the canton id is wrong');
        System.assertEquals(TestDataFactory.VAUD_CANTON_IN_API_SIMAP, selectedCantons[0].inclus_dans_API_SIMAP__c, 'testGetSelectedCantonalEntities : the canton inclusion in API SIMAP is wrong');
        System.assertEquals(TestDataFactory.VAUD_CANTON_ABBREVIATION, selectedCantons[0].Abbreviation__c, 'testGetSelectedCantonalEntities : the canton abbreviation is wrong');
    }

    @isTest
    public static void testGetSelectedFederalEntities() {
        List<Simap_Federal_Entities__c> selectedFederalEntities = new List<Simap_Federal_Entities__c>();

        Test.startTest();
            selectedFederalEntities = (List<Simap_Federal_Entities__c>) SimapUtils.getSelectedFederalEntities();
        Test.stopTest();

        System.assertEquals(1, selectedFederalEntities.size(), 'testGetSelectedFederalEntities : there should have been only one federal entity retrieved');
        System.assertEquals(TestDataFactory.FEDERAL_ENTITY1_NAME, selectedFederalEntities[0].Name, 'testGetSelectedFederalEntities : the federal entity name is wrong');
        System.assertEquals(TestDataFactory.FEDERAL_ENTITY1_ID, selectedFederalEntities[0].simap_id__c, 'testGetSelectedFederalEntities : the federal entity id is wrong');
        System.assertEquals(TestDataFactory.FEDERAL_ENTITY1_IN_API_SIMAP, selectedFederalEntities[0].inclus_dans_API_SIMAP__c, 'testGetSelectedFederalEntities : the federal entity inclusion in API SIMAP is wrong');
    }

    @isTest
    public static void testGetSelectedSimapCodesCPV() {
        List<Simap_Code_CPV__c> selectedSimapCodesCPV = new List<Simap_Code_CPV__c>();

        Test.startTest();
            selectedSimapCodesCPV = (List<Simap_Code_CPV__c>) SimapUtils.getSelectedSimapCodesCPV();
        Test.stopTest();

        System.assertEquals(1, selectedSimapCodesCPV.size(), 'testGetSelectedSimapCodesCPV : there should have been only one CPV code retrieved');
        System.assertEquals(TestDataFactory.CPV_CODE1_NAME, selectedSimapCodesCPV[0].Name, 'testGetSelectedSimapCodesCPV : the CPV name is wrong');
        System.assertEquals(TestDataFactory.CPV_CODE1_APPLY_CANTONAL_SEARCH, selectedSimapCodesCPV[0].appliquer_recherche_CANTONALE__c, 'testGetSelectedSimapCodesCPV : the CPV code cantonal search application is wrong');
        System.assertEquals(TestDataFactory.CPV_CODE1_APPLY_FEDERAL_SEARCH, selectedSimapCodesCPV[0].appliquer_recherche_FEDERALE__c, 'testGetSelectedSimapCodesCPV : the CPV code federal search application is wrong');
        System.assertEquals(TestDataFactory.CPV_CODE1_CODE, selectedSimapCodesCPV[0].Code_CPV__c, 'testGetSelectedSimapCodesCPV : the CPV code is wrong');
    }

    @isTest
    public static void testCheckAndTrimLength() {
        String testValue = '1234567890';

        String basicValue = testValue;
        String valueToTrim = '  ' + testValue + '  ';
        String longValue = 'a'.repeat(SimapUtils.CUSTOM_FIELD_MAX_LENGTH);
        String tooLongValue = 'a'.repeat(SimapUtils.CUSTOM_FIELD_MAX_LENGTH + 1);
        String nullValue = null;

        Test.startTest();
            basicValue = SimapUtils.checkAndTrimLength(basicValue);
            valueToTrim = SimapUtils.checkAndTrimLength(valueToTrim);
            longValue = SimapUtils.checkAndTrimLength(longValue);
            tooLongValue = SimapUtils.checkAndTrimLength(tooLongValue);
            nullValue = SimapUtils.checkAndTrimLength(nullValue);
        Test.stopTest();

        System.assertEquals('1234567890', basicValue, 'testCheckAndTrimLength : the basic value should not have been trimmed');
        System.assertEquals('1234567890', valueToTrim, 'testCheckAndTrimLength : the value to trim should have been trimmed');
        System.assertEquals(longValue, longValue, 'testCheckAndTrimLength : the long value should not have been trimmed');
        System.assertEquals(longValue, tooLongValue, 'testCheckAndTrimLength : the too long value should have been trimmed');
        System.assertEquals(null, nullValue, 'testCheckAndTrimLength : the null value should have been returned as null');
    }

    @isTest
    public static void testGetValidField() {
        String frOutput;
        String deOutput;
        String itOutput;
        String enOutput;
        String emptyOutput;
        String frDeOutput;

        SimapHeadersService.SimapSwissLangSet frLangSet = TestDataFactory.createSwissLangset(TestDataFactory.FR, null, null, null);
        SimapHeadersService.SimapSwissLangSet deLangSet = TestDataFactory.createSwissLangset(null, TestDataFactory.DE, null, null);
        SimapHeadersService.SimapSwissLangSet itLangSet = TestDataFactory.createSwissLangset(null, null, TestDataFactory.IT, null);
        SimapHeadersService.SimapSwissLangSet enLangSet = TestDataFactory.createSwissLangset(null, null, null, TestDataFactory.EN);
        SimapHeadersService.SimapSwissLangSet frDeLangSet = TestDataFactory.createSwissLangset(TestDataFactory.FR, TestDataFactory.DE, null, null);
        SimapHeadersService.SimapSwissLangSet emptyLangSet = TestDataFactory.createSwissLangset(null, null, null, null);

        Test.startTest();
            frOutput = SimapUtils.getValidField(frLangSet);
            deOutput = SimapUtils.getValidField(deLangSet);
            itOutput = SimapUtils.getValidField(itLangSet);
            enOutput = SimapUtils.getValidField(enLangSet);
            emptyOutput = SimapUtils.getValidField(emptyLangSet);
            frDeOutput = SimapUtils.getValidField(frDeLangSet);
        Test.stopTest();

        System.assertEquals(TestDataFactory.FR, frOutput, 'testGetValidField : the fr value should have been returned');
        System.assertEquals(TestDataFactory.DE, deOutput, 'testGetValidField : the de value should have been returned');
        System.assertEquals(TestDataFactory.IT, itOutput, 'testGetValidField : the it value should have been returned');
        System.assertEquals(TestDataFactory.EN, enOutput, 'testGetValidField : the en value should have been returned');
        System.assertEquals(null, emptyOutput, 'testGetValidField : the empty value should have been returned as null');
        System.assertEquals(TestDataFactory.FR, frDeOutput, 'testGetValidField : the fr value should have been returned'); 
    }

    @isTest
    public static void testAddressConverter() {
        SimapPublicationDetailService.SimapAdress nullAddress = TestDataFactory.createAddress(
            TestDataFactory.createSwissLangset(null, null, null, null),
            TestDataFactory.createSwissLangset(null, null, null, null),
            null,
            null,
            null
        );

        SimapPublicationDetailService.SimapAdress frAddress = TestDataFactory.createAddress(
            TestDataFactory.createSwissLangset(TestDataFactory.FR, null, null, null),
            TestDataFactory.createSwissLangset(TestDataFactory.FR, null, null, null),
            TestDataFactory.COUNTRY_CODE,
            TestDataFactory.POSTAL_CODE,
            TestDataFactory.CANTON_ID
        );

        SimapPublicationDetailService.SimapAdress deAddress = TestDataFactory.createAddress(
            TestDataFactory.createSwissLangset(null, TestDataFactory.DE, null, null),
            TestDataFactory.createSwissLangset(null, TestDataFactory.DE, null, null),
            TestDataFactory.COUNTRY_CODE,
            TestDataFactory.POSTAL_CODE,
            TestDataFactory.CANTON_ID
        );

        SimapPublicationDetailService.SimapAdress invalidAddress = TestDataFactory.createAddress(
            TestDataFactory.createSwissLangset(null, null, null, null),
            TestDataFactory.createSwissLangset(null, null, null, null),
            TestDataFactory.COUNTRY_CODE,
            null,
            TestDataFactory.CANTON_ID
        );

        SimapPublicationDetailService.SimapAdress validAddressWithMissingFields = TestDataFactory.createAddress(
            TestDataFactory.createSwissLangset(null, TestDataFactory.DE, null, null),
            TestDataFactory.createSwissLangset(null, TestDataFactory.DE, null, null),
            null,
            TestDataFactory.POSTAL_CODE,
            null
        );

        String nullAddressOutput;
        String frAddressOutput;
        String deAddressOutput;
        String invalidAddressOutput;
        String validAddressWithMissingFieldsOutput;

        Test.startTest();
            nullAddressOutput = SimapUtils.addressConverter(nullAddress);
            frAddressOutput = SimapUtils.addressConverter(frAddress);
            deAddressOutput = SimapUtils.addressConverter(deAddress);
            invalidAddressOutput = SimapUtils.addressConverter(invalidAddress);
            validAddressWithMissingFieldsOutput = SimapUtils.addressConverter(validAddressWithMissingFields);
        Test.stopTest();

        System.assertEquals(null, nullAddressOutput, 'testAddressConverter : the null address should have been returned as null');
        System.assertEquals((TestDataFactory.FR + SimapUtils.ADDRESS_SEPARATOR).repeat(2) + TestDataFactory.CANTON_ID + SimapUtils.ADDRESS_SEPARATOR + TestDataFactory.COUNTRY_CODE + SimapUtils.ADDRESS_SEPARATOR + TestDataFactory.POSTAL_CODE, frAddressOutput, 'testAddressConverter : the fr address should have been correctly formatted');
        System.assertEquals((TestDataFactory.DE + SimapUtils.ADDRESS_SEPARATOR).repeat(2) + TestDataFactory.CANTON_ID + SimapUtils.ADDRESS_SEPARATOR + TestDataFactory.COUNTRY_CODE + SimapUtils.ADDRESS_SEPARATOR + TestDataFactory.POSTAL_CODE, deAddressOutput, 'testAddressConverter : the de address should have been correctly formatted');
        System.assertEquals(null, invalidAddressOutput, 'testAddressConverter : the invalid address should have been returned as null');
        System.assertEquals((TestDataFactory.DE + SimapUtils.ADDRESS_SEPARATOR).repeat(2) + TestDataFactory.POSTAL_CODE, validAddressWithMissingFieldsOutput, 'testAddressConverter : the valid address with missing fields should have been correctly formatted');
    }

    @isTest
    public static void testGetValidPublicationTitle() {
        SimapHeadersService.PublicationDeserializer publication = (SimapHeadersService.PublicationDeserializer)JSON.deserialize(TestDataFactory.SIMAP_HEADER_RESPONSE_1, SimapHeadersService.PublicationDeserializer.class);
        String publicationTitleOutput;

        Test.startTest();
            publicationTitleOutput = SimapUtils.getValidPublicationTitle(publication);
        Test.stopTest();

        System.assertEquals(TestDataFactory.FR, publicationTitleOutput, 'testGetValidPublicationTitle : the publication title should have been correctly formatted');
    }

    @isTest
    public static void testGetValidPublicationProcOfficeName() {
        SimapHeadersService.PublicationDeserializer publication = (SimapHeadersService.PublicationDeserializer)JSON.deserialize(TestDataFactory.SIMAP_HEADER_RESPONSE_1, SimapHeadersService.PublicationDeserializer.class);
        String publicationProdOfficeNameOutput;

        Test.startTest();
            publicationProdOfficeNameOutput = SimapUtils.getValidPublicationProcOfficeName(publication);
        Test.stopTest();

        System.assertEquals(TestDataFactory.FR, publicationProdOfficeNameOutput, 'testGetValidPublicationTitle : the publication title should have been correctly formatted');
    }

    @isTest
    public static void testGetCantonNameByAbbreviation() {
        String cantonName;
        
        Test.startTest();
            cantonName = SimapUtils.getCantonNameByAbbreviation(TestDataFactory.VAUD_CANTON_ABBREVIATION);
        Test.stopTest();
        
        System.assertEquals(TestDataFactory.VAUD_CANTON_NAME, cantonName, 'testGetCantonNameByAbbreviation : the canton name should have been correctly retrieved');
    }

    @isTest
    public static void testGetValidCantonValue() {
        String cantonAbbreviation;
        SimapPublicationDetailService.SimapPublicationDetailResponse detailResponse = (SimapPublicationDetailService.SimapPublicationDetailResponse) JSON.deserialize(TestDataFactory.SIMAP_DETAIL_RESPONSE_1, SimapPublicationDetailService.SimapPublicationDetailResponse.class);
        Test.startTest();
            cantonAbbreviation = SimapUtils.getValidCantonValue(detailResponse.projectInfo);
        Test.stopTest();

        System.assertEquals(TestDataFactory.VAUD_CANTON_NAME, cantonAbbreviation, 'testGetValidCantonValue : the canton id should have been correctly retrieved');
    }

    @isTest
    public static void testGetSelectedPublicationTypes() {
        List<Simap_Type_de_Publication__c> selectedPublicationTypes = new List<Simap_Type_de_Publication__c>();

        Test.startTest();
            selectedPublicationTypes = (List<Simap_Type_de_Publication__c>) SimapUtils.getSelectedPublicationTypes();
        Test.stopTest();

        System.assertEquals(1, selectedPublicationTypes.size(), 'testGetSelectedPublicationTypes : there should have been only one publication type retrieved');
        System.assertEquals(TestDataFactory.PUBLICATION_TYPE_TENDER_NAME, selectedPublicationTypes[0].Name, 'testGetSelectedPublicationTypes : the publication type name is wrong');
        System.assertEquals(TestDataFactory.PUBLICATION_TYPE_TENDER_VALUE, selectedPublicationTypes[0].simap_value__c, 'testGetSelectedPublicationTypes : the publication type id is wrong');
        System.assertEquals(TestDataFactory.PUBLICATION_TYPE_TENDER_APPLIED, selectedPublicationTypes[0].inclus_dans_API_SIMAP__c, 'testGetSelectedPublicationTypes : the publication type inclusion in API SIMAP is wrong');
    }

    @isTest
    public static void testGetSelectedProcedureTypes() {
        List<Simap_Type_de_procedure__c> selectedProcedureTypes = new List<Simap_Type_de_procedure__c>();

        Test.startTest();
            selectedProcedureTypes = (List<Simap_Type_de_procedure__c>) SimapUtils.getSelectedProcedureTypes();
        Test.stopTest();

        System.assertEquals(1, selectedProcedureTypes.size(), 'testGetSelectedProcedureTypes : there should have been only one procedure type retrieved');
        System.assertEquals(TestDataFactory.PUBLICATION_PROCESS_TYPE_OPEN_NAME, selectedProcedureTypes[0].Name, 'testGetSelectedProcedureTypes : the procedure type name is wrong');
        System.assertEquals(TestDataFactory.PUBLICATION_PROCESS_TYPE_OPEN_VALUE, selectedProcedureTypes[0].simap_value__c, 'testGetSelectedProcedureTypes : the procedure type id is wrong');
        System.assertEquals(TestDataFactory.PUBLICATION_PROCESS_TYPE_OPEN_APPLIED, selectedProcedureTypes[0].inclus_dans_API_SIMAP__c, 'testGetSelectedProcedureTypes : the procedure type inclusion in API SIMAP is wrong');
    }

    @isTest
    public static void testGetSelectedAdjudications() {
        List<Simap_Adjudications_et_mises_a_jour__c> selectedAdjudications = new List<Simap_Adjudications_et_mises_a_jour__c>();

        Test.startTest();
            selectedAdjudications = (List<Simap_Adjudications_et_mises_a_jour__c>) SimapUtils.getSelectedAdjudications();
        Test.stopTest();

        System.assertEquals(1, selectedAdjudications.size(), 'testGetSelectedAdjudications : there should have been only one adjudication retrieved');
        System.assertEquals(TestDataFactory.PUBLICATION_ADJUDICATION_ACTIVE_NAME, selectedAdjudications[0].Name, 'testGetSelectedAdjudications : the adjudication name is wrong');
        System.assertEquals(TestDataFactory.PUBLICATION_ADJUDICATION_ACTIVE_VALUE, selectedAdjudications[0].simap_value__c, 'testGetSelectedAdjudications : the adjudication id is wrong');
        System.assertEquals(TestDataFactory.PUBLICATION_ADJUDICATION_ACTIVE_APPLIED, selectedAdjudications[0].inclus_dans_API_SIMAP__c, 'testGetSelectedAdjudications : the adjudication inclusion in API SIMAP is wrong');
    }

}