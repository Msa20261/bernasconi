public with sharing class OpportunityService {

    public class OpportunityException extends Exception {}

    @AuraEnabled
    public static String getOpportunitiesWithAccount() {
        try {
            List<Opportunity> listOfOpportunities = [
                SELECT
                    Id,
                    latitude__c,
                    longitude__c,
                    Adresse__c,
                    Name,
                    StageName,
                    Account.Name,
                    Account.Id,
                    CreatedDate,
                    Territory2.Name
                FROM
                    Opportunity
                WHERE
                    latitude__c != null
                AND longitude__c != null
                AND AccountId != null
                WITH USER_MODE
            ];

            return JSON.serialize(listOfOpportunities);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String getOpportunity(String opportunityId) {
        try {
            List<Opportunity> recordOpportunity = [
                SELECT
                    Id,
                    latitude__c,
                    longitude__c,
                    Adresse__c,
                    Name,
                    StageName,
                    Account.Name,
                    Account.Id
                FROM
                    Opportunity
                
                WHERE
                    Id = :opportunityId
                WITH USER_MODE
            ];

            return JSON.serialize(recordOpportunity);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    public static void fetchOpportunityCoords(Id opportunityId) {

        try {
            Opportunity opportunity = [
                SELECT
                    Id,
                    Adresse__c
                FROM
                    Opportunity
                WHERE
                    Id = :opportunityId
                WITH USER_MODE
                LIMIT 1
            ];

            if (opportunity == null) {
                throw new OpportunityException('No opportunity found');
            }

            Address address = opportunity.Adresse__c;

            String city = address.getCity();
            String country = address.getCountry();
            String street = address.getStreet();
            String postalCode = address.getPostalCode();
            String state = address.getState();
            System.debug('city: ' + city);
            System.debug('country: ' + country);
            System.debug('street: ' + street);
            System.debug('postalCode: ' + postalCode);
            System.debug('state: ' + state);
            // if (
            //     city == null ||
            //     country == null ||
            //     postalCode == null ||
            //     street == null
            // ) {
            //     return;
            // }

            if (!Schema.sObjectType.Opportunity.isUpdateable()) {
                throw new OpportunityException('Insufficient permissions to update Opportunity records');
            }

            String urlParameters = getUrlParams(
                city,
                country,
                street,
                postalCode,
                state
            );

            HttpRequest req = buildOpenStreetMapRequest(urlParameters);
            Http http = new Http();
            HTTPResponse res = http.send(req);

            List<OpenStreetMapResponse> data = (List<OpenStreetMapResponse>) JSON.deserialize(res.getBody(), List<OpenStreetMapResponse>.class);

            if (data.size() == 0) {
                System.debug('No coordinates found for the address: ' + street + ', ' + postalCode + ' ' + city + ', ' + country + ', ' + state);
            }

            System.debug(data);

            for (OpenStreetMapResponse item : data) {
                opportunity.latitude__c = item.lat;
                opportunity.longitude__c = item.lon;
            }

            update opportunity;

        } catch (OpportunityException e) {
            throw new OpportunityException(e.getMessage());
        }
    }

    class OpenStreetMapResponse {
        String lat;
        String lon;
    }

    public static HttpRequest buildOpenStreetMapRequest(String urlParameters) {
        HttpRequest req = new HttpRequest();
        String url = 'https://nominatim.openstreetmap.org/search?format=json&limit=1' + urlParameters;

        System.debug(url);

        req.setEndpoint(url);
        req.setMethod('GET');

        return req; 
    }

    @SuppressWarnings('PMD.ExcessiveParameterList')
    public static String getUrlParams(
        String city,
        String country,
        String street,
        String postalCode,
        String state
    ) {
        String urlParameters = '';

        if (city != null) {
            urlParameters += '&city=' + EncodingUtil.urlEncode(city, 'UTF-8');
        }
        if (country != null) {
            urlParameters += '&country=' + EncodingUtil.urlEncode(country, 'UTF-8');
        }
        if (street != null) {
            urlParameters += '&street=' + EncodingUtil.urlEncode(street, 'UTF-8');
        }
        if (postalCode != null) {
            urlParameters += '&postalCode=' + EncodingUtil.urlEncode(postalCode, 'UTF-8');
        }
        if (state != null) {
            urlParameters += '&state=' + EncodingUtil.urlEncode(state, 'UTF-8');
        }

        return urlParameters;
    }

}