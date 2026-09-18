public class OpportunityQueueable implements Queueable, Database.AllowsCallouts {

    private Id opportunityId;

    public OpportunityQueueable(Id oppId) {
        this.opportunityId = oppId;
    }

    public void execute(QueueableContext context) {
        OpportunityService.fetchOpportunityCoords(opportunityId);
    }
}