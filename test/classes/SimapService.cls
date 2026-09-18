public with sharing class SimapService {

    public class SimapException extends Exception {}

    static List<String> projectSubTypes = new List<String>{'construction'};
    public static String baseSimapURL = 'https://www.simap.ch/rest/publications/v1/project/project-search?';

    public static SimapResponse fetchSimap(String lastItem) {
        String cantonalParams = getUrlParams(lastItem);
        return getSimapResponse(cantonalParams);
    }

    public static SimapResponse getSimapResponse(String params) {
        String jsonResponse = fetchNewPublications(params);
        SimapResponse simapResponse = (SimapResponse)JSON.deserialize(jsonResponse, SimapResponse.class);
        return simapResponse;
    }

    public static String fetchNewPublications(String params) {
        HttpRequest req = buildSimapRequest(params);
        Http http = new Http();
        HTTPResponse res = http.send(req);

        if (res.getStatusCode() != 200) {
            throw new SimapException(res.getBody());
        }

        String jsonResponse = res.getBody();
        return jsonResponse;
    }

    public class SimapResponse {
        public List<PublicationDeserializer> projects;
        public Pagination pagination;
    }

    public class Pagination {
        public String lastItem;
        public Integer itemsPerPage;
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
        public Datetime offerDeadline;
        public Datetime publicationDate;
        public Boolean corrected;

        public PublicationDeserializer(Map<String, Object> json) {
            this.publicationNumber = (String)json.get('publicationNumber');
            this.publicationId = (String)json.get('publicationId'); // id to display publication's details on route https://www.simap.ch/rest/publications/v1/project/ {id} /publication-details/ {publicationId}
            this.id = (String)json.get('id'); // real publication's id
            this.projectNumber = (String)json.get('projectNumber');
            this.title = new SimapSwissLangSet();
            this.procOfficeName = new SimapSwissLangSet();
            this.offerDeadline = (Datetime)json.get('offerDeadline');
            this.publicationDate = (Datetime)json.get('publicationDate');
        }

        public PublicationDeserializer() {
            this.title = new SimapSwissLangSet();
            this.procOfficeName = new SimapSwissLangSet();
        }
    }

    public static List<SObject> getCantonalEntities() {
            return [
                SELECT 
                    Id,
                    Name,
                    simap_canton_id__c,
                    simap_id__c,
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
        req.setMethod('GET');
        req.setHeader('Accept', 'application/json, text/plain, */*'); // !importzant
        return req; 
    }

}