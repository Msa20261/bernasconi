public with sharing class QueueJob {

    public class QueueJobException extends Exception {}

    // @AuraEnabled(cacheable=true)
    // public static List<QueueJob__c> getQueueJobs() {
    //     return [
    //         SELECT Id, Name, job_id__c, status__c, job_type__c, is_final_job__c, last_item__c
    //         FROM QueueJob__c
    //         LIMIT 1
    //     ];
    // }

}