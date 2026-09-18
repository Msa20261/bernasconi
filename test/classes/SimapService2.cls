public with sharing class SimapService2 {

    public class SimapService2Exception extends Exception {}

    static List<String> projectSubTypes = new List<String>{'construction'};
    public static String baseSimapURL = 'https://www.simap.ch/rest/publications/v1/project/project-search?';
    
    public class SimapResponse {
        public List<PublicationDeserializer> projects;
        public Pagination pagination;
        public Filters filters;
        // public SimapResponse(List<SObject> cantonalEntities, List<SObject> federalEntities, List<Simap_Code_CPV__c> simapCodesCPV) {
        //     this.filters = new Filters(cantonalEntities, federalEntities, simapCodesCPV);
        // }
    }
    
    public class Pagination {
        public String lastItem;
        public Integer itemsPerPage;
    }
    
    public class Filters {
        public List<SObject> cantonalEntities;
        public List<SObject> federalEntities;
        public List<Simap_Code_CPV__c> simapCodesCPV;
    
        public Filters(List<SObject> cantonalEntities, List<SObject> federalEntities, List<Simap_Code_CPV__c> simapCodesCPV) {
            this.cantonalEntities = cantonalEntities;
            this.federalEntities = federalEntities;
            this.simapCodesCPV = simapCodesCPV;
        }
    }
    
    public class SimapSwissLangSet {
        public String fr;
        public String de;
        public String it;
        public String en;
    }
    
    public class PublicationDeserializer {
        public String publicationNumber;
        public String publicationId;
        public String id;
        public String projectNumber;
        public String projectType;
        public String pubType;
        public String processType;
        public SimapSwissLangSet title;
        public SimapSwissLangSet procOfficeName;

        public String offerDeadline;
        public String publicationDate;
        public Boolean corrected;
        public String actionStatus;
        public String opportunityUrl;
        public String creationUser;
        public String creationDate;
        
        public PublicationDeserializer(Map<String, Object> json) {
            this.publicationNumber = (String)json.get('publicationNumber');
            this.publicationId = (String)json.get('publicationId'); // id to display publication's details on route https://www.simap.ch/rest/publications/v1/project/ {id} /publication-details/ {publicationId}
            this.id = (String)json.get('id'); // real publication's id
            this.projectNumber = (String)json.get('projectNumber');
            this.title = new SimapSwissLangSet();
            this.procOfficeName = new SimapSwissLangSet();

            Datetime offerDeadline = (Datetime)json.get('offerDeadline');
            this.offerDeadline = offerDeadline.format('yyyy-MM-dd');
            Datetime publicationDate = (Datetime)json.get('offerDeadline');
            this.publicationDate = publicationDate.format('yyyy-MM-dd');
        }
    }
    
    @AuraEnabled
    public static String fetchSimap(String lastItem) {
        List<SObject> simapCantonalEntities = getCantonalEntities();
        List<SObject> simapFederalEntities = getFederalEntities();
        List<Simap_Code_CPV__c> simapCodesCPV = getSimapCodesCPV();
        
        String params = getUrlParams(lastItem);
        SimapResponse response = getSimapResponse(params, simapCantonalEntities, simapFederalEntities, simapCodesCPV);
        return JSON.serialize(response);
    }
    
    public static SimapResponse getSimapResponse(String params, List<SObject> cantonalEntities, List<SObject> federalEntities, List<Simap_Code_CPV__c> simapCodesCPV) {
        String jsonResponse = fetchNewPublications(params);
        SimapResponse simapResponse = (SimapResponse)JSON.deserialize(jsonResponse, SimapResponse.class);
        simapResponse.filters = new Filters(cantonalEntities, federalEntities, simapCodesCPV);

        Set<String> publicationIds = new Set<String>();

        for (PublicationDeserializer project : simapResponse.projects) {
            publicationIds.add(project.id);
        }

        Map<String, Publication_Simap__c> existingRecordsMap = new Map<String, Publication_Simap__c>();
        for (Publication_Simap__c record : [
            SELECT 
                Id,
                Id_publication_page__c,
                Opportunity__c,
                CreatedDate,
                CreatedBy.Name
            FROM
                Publication_Simap__c 
            WHERE
                Id_publication_page__c = :publicationIds
        ]) {
            existingRecordsMap.put(record.Id_publication_page__c, record);
        }

        for (PublicationDeserializer project : simapResponse.projects) {
            if (existingRecordsMap.containsKey(project.id)) {
                Id oppId = existingRecordsMap.get(project.id).Opportunity__c;
                if (oppId != null) {
                    project.actionStatus = 'Converted';
                    project.opportunityUrl = URL.getOrgDomainURL().toExternalForm() + '/' + oppId;
                    continue;
                }
                project.actionStatus = 'Visited';
                project.creationUser = existingRecordsMap.get(project.id).CreatedBy.Name;
                project.creationDate = existingRecordsMap.get(project.id).CreatedDate.format('yyyy-MM-dd');
                continue;
            }
            project.actionStatus = 'New';
        }

        return simapResponse;
    }
    
    public static String fetchNewPublications(String params) {
        HttpRequest req = buildSimapRequest(params);
        Http http = new Http();
        HTTPResponse res = http.send(req);
        if (res.getStatusCode() != 200) {
            throw new SimapService2Exception(res.getBody());
        }
        String jsonResponse = res.getBody();

        return jsonResponse;
    }
    
    public static String getUrlParams(String lastItem) {
        String urlParameters = '';
        List<SObject> simapCantonalEntities = getCantonalEntities();
        List<SObject> simapFederalEntities = getFederalEntities();
        List<Simap_Code_CPV__c> simapCodesCPV = getSimapCodesCPV();

        for (String projectSubType : projectSubTypes) {
            urlParameters += 'projectSubTypes=' + EncodingUtil.urlEncode(projectSubType, 'UTF-8') + '&';
        }

        for (SObject entity : simapCantonalEntities) {
            urlParameters += 'issuedByOrganizations=' + EncodingUtil.urlEncode((String)entity.get('simap_id__c'), 'UTF-8') + '&';
        }

        for (SObject entity : simapFederalEntities) {
            urlParameters += 'issuedByOrganizations=' + EncodingUtil.urlEncode((String)entity.get('simap_id__c'), 'UTF-8') + '&';
        }

        for (Simap_Code_CPV__c simapCodeCPV : simapCodesCPV) {
            urlParameters += 'cpvCodes=' + EncodingUtil.urlEncode(simapCodeCPV.Code_CPV__c, 'UTF-8') + '&';
        }

        urlParameters = urlParameters.removeEnd('&');

        if(lastItem != null && lastItem != '') {
            lastItem = '&lastItem=' + EncodingUtil.urlEncode(lastItem, 'UTF-8');
            urlParameters = urlParameters + lastItem;
        }

        return urlParameters;
    }

    public static HttpRequest buildSimapRequest(String urlParameters) {
        HttpRequest req = new HttpRequest();
        String url = baseSimapURL + urlParameters;
        req.setEndpoint(urlParameters);
        req.setEndpoint(url);
        System.debug(url);
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json, text/plain, */*'); // !importzant
        
        return req; 
    }

    public static List<SObject> getCantonalEntities() {
        return [
            SELECT 
                Id,
                Name,
                simap_canton_id__c,
                simap_id__c,
                abbreviation__c,
                inclus_dans_API_SIMAP__c
            FROM
                Simap_Cantons__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<SObject> getFederalEntities() {
        return [
            SELECT
                Id,
                Name,
                simap_federal_entity_id__c,
                simap_id__c,
                inclus_dans_API_SIMAP__c
            FROM 
                Simap_Federal_Entities__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<Publication_Simap__c> getSimapPublication(String idPublicationDetail) {
        return [
            SELECT
                Id,
                Name,
                Bureau_d_achat__c,
                Numero_de_projet__c,
                Numero_de_publication__c,
                Id_publication_detail__c,
                Id_publication_page__c,
                Titre_de_publication__c,
                Date_de_publication__c,
                Deadline_Offre__c,
                Type_de_projet__c,
                Type_de_publication__c,
                Corrige__c,
                statut__c,
                Url__c,
                Type_de_process__c,
                Denomination_CPV__c,
                Type_de_l_offre__c,
                Code_CPV__c,
                Nom_de_l_offre__c,
                Adresse_bureau_d_achat__c,
                Telephone_bureau_d_achat__c,
                Email_bureau_d_achat__c,
                Adresse_contact__c,
                Telephone_contact__c,
                Email_contact__c,
                Adresse_de_l_offre__c,
                Reference_de_l_offre__c,
                Info_generale__c,
                Opportunity__c
            FROM
                Publication_Simap__c
            WHERE
                Id_publication_detail__c = :IdPublicationDetail
            WITH USER_MODE
        ];
    }

    public static List<Simap_Code_CPV__c> getSimapCodesCPV() {
        return [
            SELECT
                Id,
                Code_CPV__c,
                appliquer_recherche_CANTONALE__c
            FROM
                Simap_Code_CPV__c
            WHERE
                appliquer_recherche_CANTONALE__c = true
            OR
                appliquer_recherche_FEDERALE__c = true
            WITH USER_MODE
        ];
    }

    public static String getValidPublicationTitle(PublicationDeserializer publication) {
        return checkAndTrimLength(getValidField(publication.title));
    }

    public static String getValidPublicationProcOfficeName(PublicationDeserializer publication) {
        return checkAndTrimLength(getValidField(publication.procOfficeName));
    }

    public static String getValidField(SimapSwissLangSet fieldMap) {
        if (fieldMap == null) {
            return '';
        }
        if (fieldMap.fr != null && fieldMap.fr != '') {
            return fieldMap.fr;
        } else if (fieldMap.de != null && fieldMap.de != '') {
            return fieldMap.de;
        } else if (fieldMap.it != null && fieldMap.it != '') {
            return fieldMap.it;
        } else if (fieldMap.en != null && fieldMap.en != '') {
            return fieldMap.en;
        } else {
            return null;
        }
    }

    public static String checkAndTrimLength(String fieldValue) {
        if (fieldValue == null) {
            return null;
        }
        return fieldValue.length() > 225 ? fieldValue.substring(0, 225) : fieldValue;
    }

}