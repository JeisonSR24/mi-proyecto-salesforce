public class CSVProductosProcessor {
    
    // Variables de Entrada desde el Flujo
    public class FlowInput {
        @InvocableVariable(label='ID del Documento (ContentDocumentId)' required=true)
        public Id documentId;
    }
    
    // Variables de Salida hacia el Flujo
    public class FlowOutput {
        @InvocableVariable(label='Mensaje de Resultado')
        public String message;
        
        @InvocableVariable(label='¿Fue Exitoso?')
        public Boolean isSuccess;
        
        @InvocableVariable(label='Productos Parseados')
        public List<ParsedProductRow> parsedProducts;
    }
    
    @InvocableMethod(label='Parsear CSV de Productos' description='Lee un CSV y busca los productos en Salesforce')
    public static List<FlowOutput> parseCSV(List<FlowInput> inputs) {
        FlowOutput output = new FlowOutput();
        output.parsedProducts = new List<ParsedProductRow>();
        output.isSuccess = true;
        
        try {
            // 1. Obtener el archivo subido
            Id docId = inputs[0].documentId;
            ContentVersion cv = [SELECT VersionData FROM ContentVersion WHERE ContentDocumentId = :docId AND IsLatest = true LIMIT 1];
            String csvBody = cv.VersionData.toString();
            
            // 2. Separar filas y extraer códigos
            List<String> rows = csvBody.split('\n');
            Map<String, Decimal> codeToQuantityMap = new Map<String, Decimal>();
            
            for(Integer i = 1; i < rows.size(); i++) { // Empezamos en 1 para saltar la cabecera
                String row = rows[i].trim();
                if(String.isNotBlank(row)) {
                    List<String> columns = row.split(',');
                    if(columns.size() >= 2) {
                        String code = columns[0].trim();
                        Decimal qty = Decimal.valueOf(columns[1].trim());
                        codeToQuantityMap.put(code, qty);
                    }
                }
            }
            
            // 3. Buscar los PricebookEntries (Asegúrate de filtrar por tu lista de precios si es necesario)
            List<PricebookEntry> pbes = [SELECT Id, UnitPrice, Product2.Name, Product2.ProductCode 
                                         FROM PricebookEntry 
                                         WHERE Product2.ProductCode IN :codeToQuantityMap.keySet() 
                                         AND Pricebook2.IsStandard = true]; // Asumiendo Lista de Precios Estándar
            
            Set<String> foundCodes = new Set<String>();
            
            // 4. Enriquecer los datos para el Flujo
            for(PricebookEntry pbe : pbes) {
                ParsedProductRow pr = new ParsedProductRow();
                pr.productCode = pbe.Product2.ProductCode;
                pr.productName = pbe.Product2.Name;
                pr.unitPrice = pbe.UnitPrice;
                pr.pricebookEntryId = pbe.Id;
                pr.quantity = codeToQuantityMap.get(pbe.Product2.ProductCode);
                
                output.parsedProducts.add(pr);
                foundCodes.add(pbe.Product2.ProductCode);
            }
            
            // 5. Validar si faltaron productos
            if(foundCodes.size() < codeToQuantityMap.size()) {
                List<String> missingCodes = new List<String>();
                for(String code : codeToQuantityMap.keySet()) {
                    if(!foundCodes.contains(code)) {
                        missingCodes.add(code);
                    }
                }
                output.isSuccess = false;
                output.message = 'Error: Los siguientes códigos no existen en Salesforce o no tienen precio activo: ' + String.join(missingCodes, ', ');
            } else {
                output.message = 'Se encontraron ' + pbes.size() + ' productos con éxito.';
            }
            
        } catch(Exception e) {
            output.isSuccess = false;
            output.message = 'Error crítico al procesar el archivo: ' + e.getMessage();
        }
        
        return new List<FlowOutput>{output};
    }
}