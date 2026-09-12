public with sharing class ContactController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        // *** Línea para forzar el error de prueba ***
        throw new AuraHandledException('Error: No pudimos recuperar los contactos debido a un fallo en el servidor.');

        /*
        // Mantenemos el bloque try/catch original para referencia, pero no será alcanzado por el 'throw' de arriba.
        try {
            return [
                SELECT Id, FirstName, LastName, Email
                FROM Contact
                WITH SECURITY_ENFORCED
                ORDER BY LastName
                LIMIT 50
            ];
        } catch (Exception e) {
            // Es crucial lanzar una AuraHandledException para que el LWC pueda procesar el mensaje.
            throw new AuraHandledException(e.getMessage());
        }
        */
    }
}