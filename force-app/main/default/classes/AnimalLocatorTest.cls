@isTest
private class AnimalLocatorTest {
    @isTest
    static void testGetAnimalNameById() {
        // Establece el mock para la llamada HTTP
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock());

        // Llama al método que se va a probar
        String animalName = AnimalLocator.getAnimalNameById(1);

        // Verifica que el método devolvió el valor esperado del mock
        System.assertEquals('Lion', animalName, 'El nombre del animal no coincide con el esperado.');
    }
}