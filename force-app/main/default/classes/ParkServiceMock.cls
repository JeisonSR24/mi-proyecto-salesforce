@isTest
public class ParkServiceMock implements WebServiceMock {
    
    public void doInvoke(
        Object stub,
        Object request,
        Map<String, Object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType
    ) {
        // Crear una respuesta mock
        ParkService.byCountryResponse mockResponse = new ParkService.byCountryResponse();
        
        // Simular diferentes respuestas según el país
        if (requestName.contains('United States') || requestName.contains('US')) {
            mockResponse.return_x = new String[]{
                'Yellowstone',
                'Grand Canyon',
                'Yosemite'
            };
        } else if (requestName.contains('Germany')) {
            mockResponse.return_x = new String[]{
                'Bavarian Forest National Park',
                'Berchtesgaden National Park'
            };
        } else if (requestName.contains('Japan')) {
            mockResponse.return_x = new String[]{
                'Fuji-Hakone-Izu National Park',
                'Nikko National Park'
            };
        } else if (requestName.contains('India')) {
            mockResponse.return_x = new String[]{
                'Kaziranga National Park',
                'Sundarbans National Park'
            };
        } else {
            // Respuesta por defecto para otros países
            mockResponse.return_x = new String[]{
                'Test Park 1',
                'Test Park 2'
            };
        }
        
        response.put('response_x', mockResponse);
    }
}