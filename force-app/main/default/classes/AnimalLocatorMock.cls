@isTest
global class AnimalLocatorMock implements HttpCalloutMock {
    // Implementa la interfaz HttpCalloutMock
    global HTTPResponse respond(HTTPRequest request) {
        // Crea una respuesta falsa
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        // Define el cuerpo de la respuesta JSON simulada
        response.setBody('{"animal":{"id":1,"name":"Lion","eats":"meat","says":"roar"}}');
        response.setStatusCode(200);
        return response;
    }
}