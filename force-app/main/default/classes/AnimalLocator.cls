public class AnimalLocator {
    public static String getAnimalNameById(Integer animalId) {
        // Prepara la solicitud HTTP
        HttpRequest request = new HttpRequest();
        // Construye el endpoint con el ID del animal
        String endpoint = 'https://th-apex-http-callout.herokuapp.com/animals/' + animalId;
        request.setEndpoint(endpoint);
        request.setMethod('GET');

        // Envía la solicitud y obtiene la respuesta
        Http http = new Http();
        HttpResponse response = http.send(request);

        // Inicializa la variable para el nombre del animal
        String animalName = '';

        // Procesa la respuesta si la llamada fue exitosa (código 200)
        if (response.getStatusCode() == 200) {
            // Deserializa la respuesta JSON
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Extrae el objeto 'animal' del mapa
            Map<String, Object> animal = (Map<String, Object>) results.get('animal');
            // Obtiene el valor de la propiedad 'name'
            animalName = (String) animal.get('name');
        }

        // Devuelve el nombre del animal
        return animalName;
    }
}