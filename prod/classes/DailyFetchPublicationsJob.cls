public class DailyFetchPublicationsJob {

    @InvocableMethod(label='Simap Fetch')
    public static void fetchSimap() {
        return;
        // System.enqueueJob(new DeletePublicationsQueuable());
        // System.enqueueJob(new PublicationSimapQueueable(null));
    }

}