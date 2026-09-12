public class ParkLocator {
    
    public static String[] country(String countryName) {
        // Crear instancia del servicio web
        ParkService.parksImplPort service = new ParkService.parksImplPort();
        
        // Llamar al método del servicio web para obtener los parques del país
        String[] parks = service.byCountry(countryName);
        
        return parks;
    }
}