@isTest
public class ParkLocatorTest {
    
    @isTest
    static void testCountryWithUnitedStates() {
        // Set mock web service
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Test the country method with United States
        String[] parks = ParkLocator.country('United States');
        
        // Assert results
        System.assertNotEquals(null, parks, 'Parks array should not be null');
        System.assert(parks.size() > 0, 'Parks array should contain at least one park');
        
        // Verify specific parks for US
        List<String> parksList = new List<String>(parks);
        System.assert(parksList.contains('Yellowstone'), 'Should contain Yellowstone');
        System.assert(parksList.contains('Grand Canyon'), 'Should contain Grand Canyon');
        System.assert(parksList.contains('Yosemite'), 'Should contain Yosemite');
    }
    
    @isTest
    static void testCountryWithGermany() {
        // Set mock web service
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Test the country method with Germany
        String[] parks = ParkLocator.country('Germany');
        
        // Assert results
        System.assertNotEquals(null, parks, 'Parks array should not be null');
        System.assert(parks.size() > 0, 'Parks array should contain at least one park');
        
        // Verify specific parks for Germany
        List<String> parksList = new List<String>(parks);
        System.assert(parksList.contains('Bavarian Forest National Park'), 'Should contain Bavarian Forest National Park');
        System.assert(parksList.contains('Berchtesgaden National Park'), 'Should contain Berchtesgaden National Park');
    }
    
    @isTest
    static void testCountryWithJapan() {
        // Set mock web service
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Test the country method with Japan
        String[] parks = ParkLocator.country('Japan');
        
        // Assert results
        System.assertNotEquals(null, parks, 'Parks array should not be null');
        System.assert(parks.size() > 0, 'Parks array should contain at least one park');
        
        // Verify specific parks for Japan
        List<String> parksList = new List<String>(parks);
        System.assert(parksList.contains('Fuji-Hakone-Izu National Park'), 'Should contain Fuji-Hakone-Izu National Park');
        System.assert(parksList.contains('Nikko National Park'), 'Should contain Nikko National Park');
    }
    
    @isTest
    static void testCountryWithIndia() {
        // Set mock web service
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Test the country method with India
        String[] parks = ParkLocator.country('India');
        
        // Assert results
        System.assertNotEquals(null, parks, 'Parks array should not be null');
        System.assert(parks.size() > 0, 'Parks array should contain at least one park');
        
        // Verify specific parks for India
        List<String> parksList = new List<String>(parks);
        System.assert(parksList.contains('Kaziranga National Park'), 'Should contain Kaziranga National Park');
        System.assert(parksList.contains('Sundarbans National Park'), 'Should contain Sundarbans National Park');
    }
    
    @isTest
    static void testCountryWithOtherCountry() {
        // Set mock web service
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        
        // Test the country method with a different country
        String[] parks = ParkLocator.country('Brazil');
        
        // Assert results
        System.assertNotEquals(null, parks, 'Parks array should not be null');
        System.assert(parks.size() > 0, 'Parks array should contain at least one park');
        
        // Verify default parks response
        List<String> parksList = new List<String>(parks);
        System.assert(parksList.contains('Test Park 1'), 'Should contain Test Park 1');
        System.assert(parksList.contains('Test Park 2'), 'Should contain Test Park 2');
    }
}