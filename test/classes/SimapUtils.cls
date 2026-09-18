public with sharing class SimapUtils {

    public class SimapUtilsException extends Exception {}

    public static final Integer CUSTOM_FIELD_MAX_LENGTH = 225;
    public static final String ADDRESS_SEPARATOR = ', ';

    public static List<SObject> getSelectedCantonalEntities() {
        return [
            SELECT 
                Id,
                Name,
                simap_id__c,
                Abbreviation__c,
                inclus_dans_API_SIMAP__c
            FROM
                Simap_Cantons__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<SObject> getSelectedFederalEntities() {
        return [
            SELECT
                Id,
                Name,
                simap_id__c,
                inclus_dans_API_SIMAP__c
            FROM 
                Simap_Federal_Entities__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<SObject> getSelectedPublicationTypes() {
        return [
            SELECT
                Id,
                Name,
                simap_value__c,
                inclus_dans_API_SIMAP__c
            FROM 
                Simap_Type_de_Publication__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<SObject> getSelectedProcedureTypes() {
        return [
            SELECT
                Id,
                Name,
                simap_value__c,
                inclus_dans_API_SIMAP__c
            FROM 
                Simap_Type_de_procedure__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<SObject> getSelectedAdjudications() {
        return [
            SELECT
                Id,
                Name,
                simap_value__c,
                inclus_dans_API_SIMAP__c
            FROM 
                Simap_Adjudications_et_mises_a_jour__c
            WHERE
                inclus_dans_API_SIMAP__c = true
            WITH USER_MODE
        ];
    }

    public static List<Simap_Code_CPV__c> getSelectedSimapCodesCPV() {
        return [
            SELECT
                Id,
                Name,
                Code_CPV__c,
                appliquer_recherche_CANTONALE__c,
                appliquer_recherche_FEDERALE__c
            FROM
                Simap_Code_CPV__c
            WHERE
                appliquer_recherche_CANTONALE__c = true
            OR
                appliquer_recherche_FEDERALE__c = true
            WITH USER_MODE
        ];
    }

    public static String checkAndTrimLength(String fieldValue) {
        if (fieldValue == null) {
            return null;
        }
        fieldValue = fieldValue.trim();
        return fieldValue.length() > CUSTOM_FIELD_MAX_LENGTH ? fieldValue.substring(0, CUSTOM_FIELD_MAX_LENGTH) : fieldValue;
    }

    public static String getValidField(SimapHeadersService.SimapSwissLangSet fieldMap) {
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

    public static String addressConverter(SimapPublicationDetailService.SimapAdress addr) {
        if (
            addr?.city == null ||
            addr?.postalCode == null ||
            addr?.street == null
        ) {
            return null;
        }
        String parsedAddress = '';

        String parsedStreet = getValidField(addr.street);
        String parsedCity = getValidField(addr.city);

        List<String> addressParts = new List<String> {
            parsedStreet,
            parsedCity,
            addr.cantonId,
            addr.countryId,
            addr.postalCode
        };

        for(String addressPart : addressParts) {
            if(!String.isBlank(addressPart) && addressPart != null) {
                parsedAddress += addressPart + ADDRESS_SEPARATOR;
            }
        }

        parsedAddress = parsedAddress.removeEnd(ADDRESS_SEPARATOR);
        return parsedAddress;
    }

    public static String getValidPublicationTitle(SimapHeadersService.PublicationDeserializer publication) {
        return checkAndTrimLength(getValidField(publication.title));
    }

    public static String getValidPublicationProcOfficeName(SimapHeadersService.PublicationDeserializer publication) {
        return checkAndTrimLength(getValidField(publication.procOfficeName));
    }

    public static String getValidCantonValue(SimapPublicationDetailService.ProjectInfo projectInfo) {
        if (projectInfo.procOfficeAddress?.cantonId != null) {
            String cantonName = getCantonNameByAbbreviation(projectInfo.procOfficeAddress.cantonId);
            if (cantonName != null) {
                return cantonName;
            }
        }
        if (projectInfo.procurementRecipientAddress?.cantonId != null) {
            String cantonName = getCantonNameByAbbreviation(projectInfo.procurementRecipientAddress.cantonId);
            if (cantonName != null) {
                return cantonName;
            }
        }
        if (projectInfo.offerAddress?.cantonId != null) {
            String cantonName = getCantonNameByAbbreviation(projectInfo.offerAddress.cantonId);
            if (cantonName != null) {
                return cantonName;
            }
        }

        return null;
    }

    public static String getCantonNameByAbbreviation(String cantonId) {
        List<SObject> simapCantonalEntities = SimapUtils.getSelectedCantonalEntities();
        for (SObject entity : simapCantonalEntities) {
            if ((String) entity.get('Abbreviation__c') == cantonId) {
                return (String) entity.get('Name');
            }
        }
        return null;
    }

}