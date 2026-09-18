@isTest
public class MockHttpSimapResponseDetail implements HttpCalloutMock {

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);

        if(req.getEndpoint().contains('/publication-details/')) {
            res.setBody(TestDataFactory.SIMAP_DETAIL_RESPONSE_1);
        }

        return res;
    }
}