@isTest
public class MockHttpOpenStreetMapResponse implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();

        if (req.getEndpoint().contains('street=bbbbbbbbbbbbb')) {
            res.setStatusCode(200);
            res.setBody('[]');
        } else {
            res.setStatusCode(200);
            res.setBody('[{"lat": "48.866667", "lon": "2.333333"}]');
        }

        return res;
    }
}