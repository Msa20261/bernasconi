trigger PublicationSimap on Publication_Simap__c (after insert) {
    System.debug('trigger');
    System.debug(Trigger.new);
    // List<SimapProcessingComplete__e> notifications = new List<SimapProcessingComplete__e>();

    // notifications.add(new SimapProcessingComplete__e(Message__c = 'hello'));
    // List<Database.SaveResult> results = EventBus.publish(notifications);
    // for (Database.SaveResult result : results) {
    //     System.debug(result);
    //     if (!result.isSuccess()) {
    //         for (Database.Error error : result.getErrors()) {
    //             System.debug('Error returned: ' + error.getStatusCode() +' - '+ error.getMessage());
    //         }
    //     }
    // }
}