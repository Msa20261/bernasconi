trigger OpportunityTrigger on Opportunity (after insert, after update) {

    if (TriggerHandler.bypassOpportunityTrigger) {
        return;
    }

    List<Id> opportunityIds = new List<Id>();

    if (Trigger.isInsert) {
        System.debug('INSERT TRIGGER');
        for (Schema.Opportunity opp : Trigger.new) {
            opportunityIds.add(opp.Id);
        }
        for (Id oppId : opportunityIds) {
            System.enqueueJob(new OpportunityQueueable(oppId));
        }
    }

    if (Trigger.isUpdate) {
        System.debug('UPDATE TRIGGER');
        for (Schema.Opportunity opp : Trigger.new) {
            Boolean isCityChanged = Trigger.oldMap.get(opp.Id).Adresse__city__s != Trigger.newMap.get(opp.Id).Adresse__city__s;
            Boolean isStreetChanged = Trigger.oldMap.get(opp.Id).Adresse__street__s != Trigger.newMap.get(opp.Id).Adresse__street__s;
            Boolean isZipCodeChanged = Trigger.oldMap.get(opp.Id).Adresse__postalCode__s != Trigger.newMap.get(opp.Id).Adresse__postalCode__s;

            if(iscityChanged || isStreetChanged || isZipCodeChanged) {
                opportunityIds.add(opp.Id);
            }
        }
        if (opportunityIds.size() > 0) {
            for (Id oppId : opportunityIds) {
                System.enqueueJob(new OpportunityQueueable(oppId));
            }
        }
    }

}