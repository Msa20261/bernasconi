trigger AccountTrigger on Account (after insert) {

    List<Id> AccountIds = new List<Id>();

    for (Account currAccount : Trigger.new) {
        System.debug(currAccount);
    }

}